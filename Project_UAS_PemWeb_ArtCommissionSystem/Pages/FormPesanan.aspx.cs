using System;
using System.Configuration;
using Npgsql;

namespace Project_UAS_PemWeb_ArtCommissionSystem.Pages
{
    public partial class FormPesanan : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["ArtCommissionDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Mengecek apakah ada parameter ID paket di URL
                if (Request.QueryString["id"] != null)
                {
                    string idPaket = Request.QueryString["id"];
                    hfIdPaket.Value = idPaket;
                    LoadDetailPaket(idPaket);
                }
                else
                {
                    // Jika ada yang iseng buka form tanpa milih paket, tendang balik ke home
                    Response.Redirect("~/Default.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                }
            }
        }

        private void LoadDetailPaket(string idPaket)
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT nama_paket, harga FROM Paket_Layanan WHERE id_paket = @id";
                    using (NpgsqlCommand cmd = new NpgsqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", Convert.ToInt32(idPaket));
                        using (NpgsqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblNamaPaket.Text = reader["nama_paket"].ToString();
                                decimal harga = Convert.ToDecimal(reader["harga"]);
                                lblHargaPaket.Text = $"Rp {harga:N0}";
                            }
                            else
                            {
                                Response.Redirect("~/Default.aspx", false);
                                Context.ApplicationInstance.CompleteRequest();
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Gagal memuat detail paket: {ex.Message}');", true);
                }
            }
        }

        protected void btnKirimPesanan_Click(object sender, EventArgs e)
        {
            string nama = txtNamaPemesan.Text.Trim();
            string kontak = txtKontak.Text.Trim();
            string catatan = txtCatatan.Text.Trim();
            string idPaket = hfIdPaket.Value;

            // Validasi input kosong
            if (string.IsNullOrEmpty(nama) || string.IsNullOrEmpty(kontak))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Nama dan Kontak wajib diisi!');", true);
                return;
            }

            using (NpgsqlConnection conn = new NpgsqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    // Menyimpan data ke tabel Pesanan, status default 'Pending' otomatis dari PostgreSQL
                    string query = "INSERT INTO Pesanan (nama_pemesan, kontak, id_paket, catatan) VALUES (@nama, @kontak, @id_paket, @catatan)";
                    using (NpgsqlCommand cmd = new NpgsqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@nama", nama);
                        cmd.Parameters.AddWithValue("@kontak", kontak);
                        cmd.Parameters.AddWithValue("@id_paket", Convert.ToInt32(idPaket));
                        cmd.Parameters.AddWithValue("@catatan", catatan);

                        cmd.ExecuteNonQuery();
                    }

                    // Tampilkan sukses lalu redirect ke beranda
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Pesanan berhasil dikirim! Admin akan segera menghubungi Anda.'); window.location='../Default.aspx';", true);
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Gagal mengirim pesanan: {ex.Message}');", true);
                }
            }
        }
    }
}