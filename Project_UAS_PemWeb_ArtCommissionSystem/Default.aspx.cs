using System;
using System.Configuration;
using System.Text;
using Npgsql;

namespace Project_UAS_PemWeb_ArtCommissionSystem
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Pastikan data hanya dimuat saat halaman pertama kali dibuka
            if (!IsPostBack)
            {
                LoadKatalog();
            }
        }

        private void LoadKatalog()
        {
            string connString = ConfigurationManager.ConnectionStrings["ArtCommissionDB"].ConnectionString;

            using (NpgsqlConnection conn = new NpgsqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    // Mengambil semua data paket layanan dari database
                    string query = "SELECT id_paket, nama_paket, deskripsi, harga FROM Paket_Layanan ORDER BY id_paket ASC";

                    using (NpgsqlCommand cmd = new NpgsqlCommand(query, conn))
                    {
                        using (NpgsqlDataReader reader = cmd.ExecuteReader())
                        {
                            // Menggunakan StringBuilder untuk merangkai kode HTML
                            StringBuilder htmlBuilder = new StringBuilder();

                            while (reader.Read())
                            {
                                // Mengambil ID Paket untuk dilempar ke form pesanan
                                string idPaket = reader["id_paket"].ToString();
                                string nama = reader["nama_paket"].ToString();
                                string deskripsi = reader["deskripsi"].ToString();
                                decimal harga = Convert.ToDecimal(reader["harga"]);

                                // Membuat template Card Bootstrap dengan link yang sudah dinamis
                                htmlBuilder.Append($@"
                                    <div class='col-md-4 mb-4'>
                                        <div class='card h-100 shadow-sm border-0'>
                                            <div class='card-body d-flex flex-column'>
                                                <h5 class='card-title fw-bold text-primary'>{nama}</h5>
                                                <h6 class='card-subtitle mb-3 text-success fw-bold'>Rp {harga:N0}</h6>
                                                <p class='card-text text-muted flex-grow-1'>{deskripsi}</p>
                                                <!-- Href sudah diubah untuk membawa parameter ID -->
                                                <a href='Pages/FormPesanan.aspx?id={idPaket}' class='btn btn-outline-primary mt-3'>Pesan Sekarang</a>
                                            </div>
                                        </div>
                                    </div>
                                ");
                            }

                            // Memasukkan HTML yang sudah dirangkai ke dalam wadah di Default.aspx
                            katalogContainer.InnerHtml = htmlBuilder.ToString();
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Tampilkan pesan error langsung di halaman jika koneksi gagal
                    katalogContainer.InnerHtml = $"<div class='alert alert-danger'>Gagal memuat katalog: {ex.Message}</div>";
                }
            }
        }
    }
}