using System;
using System.Data;
using System.Configuration;
using System.Web.UI.WebControls;
using Npgsql;

namespace Project_UAS_PemWeb_ArtCommissionSystem.Pages
{
    public partial class KelolaPaket : System.Web.UI.Page
    {
        // Mengambil connection string dari Web.config
        string connString = ConfigurationManager.ConnectionStrings["ArtCommissionDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Proteksi halaman: Hanya admin yang boleh masuk
            if (Session["Username"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("~/Pages/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                LoadDataPaket();
            }
        }

        // --- READ: Menampilkan data ke dalam GridView ---
        private void LoadDataPaket()
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT id_paket, nama_paket, deskripsi, harga FROM Paket_Layanan ORDER BY id_paket ASC";
                    using (NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, conn))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvPaketLayanan.DataSource = dt;
                        gvPaketLayanan.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Gagal memuat data: {ex.Message}');", true);
                }
            }
        }

        // --- CREATE: Menambahkan paket baru ---
        protected void btnSimpan_Click(object sender, EventArgs e)
        {
            string nama = txtNamaPaket.Text.Trim();
            string deskripsi = txtDeskripsi.Text.Trim();
            string hargaText = txtHarga.Text.Trim();

            if (string.IsNullOrEmpty(nama) || string.IsNullOrEmpty(hargaText))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Nama Paket dan Harga wajib diisi!');", true);
                return;
            }

            using (NpgsqlConnection conn = new NpgsqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    string query = "INSERT INTO Paket_Layanan (nama_paket, deskripsi, harga) VALUES (@nama, @desk, @harga)";
                    using (NpgsqlCommand cmd = new NpgsqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@nama", nama);
                        cmd.Parameters.AddWithValue("@desk", deskripsi);
                        cmd.Parameters.AddWithValue("@harga", Convert.ToDecimal(hargaText));

                        cmd.ExecuteNonQuery();
                    }

                    // Bersihkan form dan muat ulang tabel
                    txtNamaPaket.Text = "";
                    txtDeskripsi.Text = "";
                    txtHarga.Text = "";
                    LoadDataPaket();
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Paket berhasil ditambahkan!');", true);
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Gagal menyimpan: {ex.Message}');", true);
                }
            }
        }

        // --- UPDATE: Masuk ke mode edit baris ---
        protected void gvPaketLayanan_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvPaketLayanan.EditIndex = e.NewEditIndex;
            LoadDataPaket();
        }

        // --- UPDATE: Membatalkan mode edit ---
        protected void gvPaketLayanan_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvPaketLayanan.EditIndex = -1;
            LoadDataPaket();
        }

        // --- UPDATE: Menyimpan perubahan data ---
        protected void gvPaketLayanan_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int idPaket = Convert.ToInt32(gvPaketLayanan.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvPaketLayanan.Rows[e.RowIndex];

            string nama = (row.Cells[1].Controls[0] as TextBox).Text;
            string desk = (row.Cells[2].Controls[0] as TextBox).Text;
            string hargaText = (row.Cells[3].Controls[0] as TextBox).Text;

            using (NpgsqlConnection conn = new NpgsqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    string query = "UPDATE Paket_Layanan SET nama_paket=@nama, deskripsi=@desk, harga=@harga WHERE id_paket=@id";
                    using (NpgsqlCommand cmd = new NpgsqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@nama", nama);
                        cmd.Parameters.AddWithValue("@desk", desk);
                        cmd.Parameters.AddWithValue("@harga", Convert.ToDecimal(hargaText));
                        cmd.Parameters.AddWithValue("@id", idPaket);

                        cmd.ExecuteNonQuery();
                    }

                    gvPaketLayanan.EditIndex = -1;
                    LoadDataPaket();
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Gagal mengupdate: {ex.Message}');", true);
                }
            }
        }

        // --- DELETE: Menghapus data ---
        protected void gvPaketLayanan_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int idPaket = Convert.ToInt32(gvPaketLayanan.DataKeys[e.RowIndex].Value);

            using (NpgsqlConnection conn = new NpgsqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    string query = "DELETE FROM Paket_Layanan WHERE id_paket=@id";
                    using (NpgsqlCommand cmd = new NpgsqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", idPaket);
                        cmd.ExecuteNonQuery();
                    }

                    LoadDataPaket();
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Gagal menghapus: {ex.Message}');", true);
                }
            }
        }
    }
}