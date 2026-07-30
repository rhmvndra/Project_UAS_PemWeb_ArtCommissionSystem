using System;
using System.Data;
using System.Configuration;
using System.Web.UI.WebControls;
using Npgsql;

namespace Project_UAS_PemWeb_ArtCommissionSystem.Pages
{
    public partial class KelolaPesanan : System.Web.UI.Page
    {
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
                LoadDataPesanan();
            }
        }

        private void LoadDataPesanan()
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    // Menggunakan JOIN untuk menggabungkan data pesanan dengan nama paket layanannya
                    string query = @"
                        SELECT p.id_pesanan, p.nama_pemesan, p.kontak, p.catatan, p.tanggal_pesan, p.status, l.nama_paket 
                        FROM Pesanan p 
                        JOIN Paket_Layanan l ON p.id_paket = l.id_paket 
                        ORDER BY p.tanggal_pesan DESC";

                    using (NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, conn))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvPesanan.DataSource = dt;
                        gvPesanan.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Gagal memuat data pesanan: {ex.Message}');", true);
                }
            }
        }

        // Logika untuk tombol aksi (Terima Pesanan & Tandai Selesai)
        protected void gvPesanan_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int idPesanan = Convert.ToInt32(e.CommandArgument);
            string statusBaru = "";

            if (e.CommandName == "ProsesPesanan")
            {
                statusBaru = "Diproses";
            }
            else if (e.CommandName == "SelesaiPesanan")
            {
                statusBaru = "Selesai";
            }

            if (!string.IsNullOrEmpty(statusBaru))
            {
                using (NpgsqlConnection conn = new NpgsqlConnection(connString))
                {
                    try
                    {
                        conn.Open();
                        string query = "UPDATE Pesanan SET status = @status WHERE id_pesanan = @id";
                        using (NpgsqlCommand cmd = new NpgsqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@status", statusBaru);
                            cmd.Parameters.AddWithValue("@id", idPesanan);
                            cmd.ExecuteNonQuery();
                        }

                        // Muat ulang tabel setelah status berubah
                        LoadDataPesanan();
                    }
                    catch (Exception ex)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Gagal mengubah status: {ex.Message}');", true);
                    }
                }
            }
        }
    }
}