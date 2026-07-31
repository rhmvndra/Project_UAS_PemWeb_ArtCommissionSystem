using System;
using System.Data;
using System.Configuration;
using System.Web.UI.WebControls;
using Npgsql;

namespace Project_UAS_PemWeb_ArtCommissionSystem
{
    public partial class CekPesanan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Tidak ada aksi otomatis saat halaman dimuat, kita menunggu klik tombol "Cari"
        }

        protected void btnCari_Click(object sender, EventArgs e)
        {
            string kontak = txtKontakPencarian.Text.Trim();

            // Validasi jika textbox kosong
            if (string.IsNullOrEmpty(kontak))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Silakan masukkan nomor WhatsApp atau Email Anda!');", true);
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["ArtCommissionDB"].ConnectionString;

            using (NpgsqlConnection conn = new NpgsqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    // Mencari pesanan berdasarkan kontak, diurutkan dari yang paling baru
                    string query = @"
                        SELECT p.tanggal_pesan, l.nama_paket, p.catatan, p.status 
                        FROM Pesanan p
                        JOIN Paket_Layanan l ON p.id_paket = l.id_paket
                        WHERE p.kontak = @kontak
                        ORDER BY p.tanggal_pesan DESC";

                    using (NpgsqlCommand cmd = new NpgsqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@kontak", kontak);

                        using (NpgsqlDataAdapter da = new NpgsqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                // Jika ada histori pesanan, tampilkan tabel dan sembunyikan pesan error
                                gvHasilPencarian.DataSource = dt;
                                gvHasilPencarian.DataBind();

                                panelHasil.Visible = true;
                                panelTidakDitemukan.Visible = false;
                            }
                            else
                            {
                                // Jika nomor tidak ditemukan, sembunyikan tabel dan tampilkan alert
                                panelHasil.Visible = false;
                                panelTidakDitemukan.Visible = true;
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Terjadi kesalahan sistem: {ex.Message}');", true);
                }
            }
        }
    }
}