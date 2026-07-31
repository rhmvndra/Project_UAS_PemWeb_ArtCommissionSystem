using System;
using System.Data;
using System.Configuration;
using System.Web.UI.WebControls;
using Npgsql;

namespace Project_UAS_PemWeb_ArtCommissionSystem.Pages
{
    public partial class LaporanPendapatan : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["ArtCommissionDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Proteksi halaman admin
            if (Session["Username"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("~/Pages/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                LoadLaporan();
            }
        }

        private void LoadLaporan()
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(connString))
            {
                try
                {
                    conn.Open();

                    // 1. Ambil data Ringkasan (Total Pendapatan & Total Proyek)
                    string querySummary = @"
                        SELECT 
                            COUNT(p.id_pesanan) AS total_pesanan, 
                            COALESCE(SUM(l.harga), 0) AS total_pendapatan
                        FROM Pesanan p
                        JOIN Paket_Layanan l ON p.id_paket = l.id_paket
                        WHERE p.status = 'Selesai'";

                    using (NpgsqlCommand cmdSum = new NpgsqlCommand(querySummary, conn))
                    {
                        using (NpgsqlDataReader reader = cmdSum.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                int totalProyek = Convert.ToInt32(reader["total_pesanan"]);
                                decimal totalPendapatan = Convert.ToDecimal(reader["total_pendapatan"]);

                                lblTotalProyek.Text = totalProyek.ToString();
                                lblTotalPendapatan.Text = $"Rp {totalPendapatan:N0}";
                            }
                        }
                    }

                    // 2. Ambil data detail untuk dimasukkan ke GridView
                    string queryDetail = @"
                        SELECT p.id_pesanan, p.tanggal_pesan, p.nama_pemesan, l.nama_paket, l.harga
                        FROM Pesanan p
                        JOIN Paket_Layanan l ON p.id_paket = l.id_paket
                        WHERE p.status = 'Selesai'
                        ORDER BY p.tanggal_pesan DESC";

                    using (NpgsqlDataAdapter da = new NpgsqlDataAdapter(queryDetail, conn))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvLaporan.DataSource = dt;
                        gvLaporan.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Gagal memuat laporan: {ex.Message}');", true);
                }
            }
        }
    }
}