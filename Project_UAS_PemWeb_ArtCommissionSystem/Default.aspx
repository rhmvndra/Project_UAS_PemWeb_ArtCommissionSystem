<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Project_UAS_PemWeb_ArtCommissionSystem.Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Art Commission - Beranda</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
    <form id="form1" runat="server">
        <!-- Navbar Publik -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
            <div class="container">
                <a class="navbar-brand fw-bold" href="Default.aspx">🎨 Art Studio</a>
                <div class="d-flex">
                    <a href="CekPesanan.aspx" class="btn btn-info btn-sm me-2 text-white">Cek Pesanan Saya</a>
                    <a href="Pages/Login.aspx" class="btn btn-outline-light btn-sm">Login Admin</a>
                </div>
            </div>
        </nav>

        <!-- Hero Section -->
        <div class="container mt-5 text-center">
            <h1 class="display-4 fw-bold text-dark">Wujudkan Imajinasimu</h1>
            <p class="lead text-muted">Pilih paket komisi di bawah ini dan biarkan kami menggambar karakter favoritmu.</p>
            <hr class="w-25 mx-auto mb-5" />
        </div>

        <!-- Katalog Paket (Akan diisi dinamis dari C#) -->
        <div class="container mb-5">
            <div class="row" id="katalogContainer" runat="server">
                <!-- Data dari PostgreSQL akan muncul di sini sebagai kartu (Cards) -->
            </div>
        </div>
    </form>
</body>
</html>