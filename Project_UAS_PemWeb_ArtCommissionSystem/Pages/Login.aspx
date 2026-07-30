using System;
using System.Configuration;
using Npgsql;

namespace Project_UAS_PemWeb_ArtCommissionSystem.Pages
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Jika sudah ada sesi (sudah login), bisa diarahkan ke dashboard
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Mengambil connection string dari Web.config
            string connString = ConfigurationManager.ConnectionStrings["ArtCommissionDB"].ConnectionString;
            
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            using (NpgsqlConnection conn = new NpgsqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    // Query untuk mengecek kecocokan data
                    string query = "SELECT role FROM Users WHERE username = @username AND password_hash = @password";
                    
                    using (NpgsqlCommand cmd = new NpgsqlCommand(query, conn))
                    {
                        // Menggunakan parameter untuk mencegah SQL Injection
                        cmd.Parameters.AddWithValue("@username", username);
                        cmd.Parameters.AddWithValue("@password", password);

                        object result = cmd.ExecuteScalar();

                        if (result != null)
                        {
                            // Jika berhasil login, simpan info di Session
                            string role = result.ToString();
                            Session["Username"] = username;
                            Session["Role"] = role;

                            // Menampilkan pesan sukses sementara (nanti bisa diganti Response.Redirect)
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Login Berhasil! Selamat datang, {role}.');", true);
                        }
                        else
                        {
                            // Jika username/password salah
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Username atau Password salah!');", true);
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Menampilkan pesan error jika database gagal terhubung
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error Koneksi: {ex.Message}');", true);
                }
            }
        }
    }
}