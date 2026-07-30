using System;
using System.Configuration;
using Npgsql;

namespace Project_UAS_PemWeb_ArtCommissionSystem.Pages
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string connString = ConfigurationManager.ConnectionStrings["ArtCommissionDB"].ConnectionString;
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            using (NpgsqlConnection conn = new NpgsqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT role FROM Users WHERE username = @username AND password_hash = @password";

                    using (NpgsqlCommand cmd = new NpgsqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@username", username);
                        cmd.Parameters.AddWithValue("@password", password);

                        object result = cmd.ExecuteScalar();

                        if (result != null)
                        {
                            string role = result.ToString();
                            Session["Username"] = username;
                            Session["Role"] = role;

                            ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Login Berhasil! Selamat datang, {role}.');", true);
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Username atau Password salah!');", true);
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/Pages/DashboardAdmin.aspx");
                }
            }
        }
    }
}