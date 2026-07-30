<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Project_UAS_PemWeb_ArtCommissionSystem.Pages.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Login - Art Commission System</title>
    <!-- Memasukkan Bootstrap CSS CDN untuk tampilan responsif -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light d-flex align-items-center py-5" style="height: 100vh;">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow-sm border-0 rounded-4">
                    <div class="card-body p-4 p-md-5">
                        <h2 class="text-center mb-4 fw-bold text-primary">Art Commission</h2>
                        <p class="text-center text-muted mb-4">Silakan masuk ke akun Anda</p>
                        
                        <form id="form1" runat="server">
                            <div class="mb-3">
                                <label for="txtUsername" class="form-label">Username</label>
                                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Masukkan username"></asp:TextBox>
                            </div>
                            
                            <div class="mb-3">
                                <label for="txtPassword" class="form-label">Password</label>
                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Masukkan password"></asp:TextBox>
                            </div>

                            <div class="d-grid gap-2 mt-4">
                                <asp:Button ID="btnLogin" runat="server" Text="Masuk" CssClass="btn btn-primary btn-lg" OnClick="btnLogin_Click" />
                            </div>

                            <div class="text-center mt-3">
                                <small class="text-muted">Belum punya akun? Hubungi Admin.</small>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>