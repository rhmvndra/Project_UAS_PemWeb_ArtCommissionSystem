<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DashboardAdmin.aspx.cs" Inherits="Project_UAS_PemWeb_ArtCommissionSystem.Pages.DashboardAdmin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Admin Dashboard - Art Commission</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
    <form id="form1" runat="server">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
            <div class="container-fluid">
                <a class="navbar-brand fw-bold" href="#">Art Commission Admin</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-toggle="target" aria-controls="navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <span class="nav-link text-white me-3">
                                Halo, <asp:Label ID="lblUsername" runat="server" Text="Admin" CssClass="fw-bold"></asp:Label>!
                            </span>
                        </li>
                        <li class="nav-item">
                            <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-danger btn-sm mt-1" OnClick="btnLogout_Click" />
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="container mt-5">
            <div class="row">
                <!-- Sidebar / Menu Kiri -->
                <div class="col-md-3 mb-4">
                    <div class="list-group shadow-sm">
                        <a href="#" class="list-group-item list-group-item-action active">Dashboard Utama</a>
                        <a href="KelolaPaket.aspx class="list-group-item list-group-item-action">Kelola Paket Layanan</a>
                        <a href="#" class="list-group-item list-group-item-action">Daftar Pesanan (Transaksi)</a>
                        <a href="#" class="list-group-item list-group-item-action">Laporan Pendapatan</a>
                    </div>
                </div>

                <!-- Konten Kanan -->
                <div class="col-md-9">
                    <div class="card shadow-sm border-0">
                        <div class="card-body">
                            <h4 class="card-title text-primary mb-4">Selamat Datang di Panel Kontrol</h4>
                            <p class="card-text text-muted">Gunakan menu di sebelah kiri untuk mengelola master data layanan atau meninjau transaksi pesanan baru.</p>
                            
                            <hr />
                            
                            <!-- Area untuk tabel data nantinya -->
                            <div class="alert alert-info" role="alert">
                                <strong>Info:</strong> Belum ada data transaksi yang masuk hari ini.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>