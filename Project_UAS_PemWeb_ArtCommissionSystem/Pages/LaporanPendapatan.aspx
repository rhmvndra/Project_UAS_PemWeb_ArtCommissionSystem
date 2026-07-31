<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LaporanPendapatan.aspx.cs" Inherits="Project_UAS_PemWeb_ArtCommissionSystem.Pages.LaporanPendapatan" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Laporan Pendapatan - Art Commission</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
    <form id="form1" runat="server">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
            <div class="container-fluid">
                <a class="navbar-brand fw-bold" href="DashboardAdmin.aspx">Art Commission Admin</a>
                <div class="d-flex">
                    <a href="DashboardAdmin.aspx" class="btn btn-outline-light btn-sm">Kembali ke Dashboard</a>
                </div>
            </div>
        </nav>

        <div class="container mt-5">
            <h4 class="text-primary mb-4">Laporan Pendapatan</h4>
            
            <!-- Kartu Ringkasan (Summary) -->
            <div class="row mb-4">
                <div class="col-md-6">
                    <div class="card text-white bg-success shadow-sm border-0 h-100">
                        <div class="card-body">
                            <h6 class="card-title text-uppercase fw-bold text-white-50">Total Pendapatan Kotos</h6>
                            <h2 class="display-6 fw-bold mb-0">
                                <asp:Label ID="lblTotalPendapatan" runat="server" Text="Rp 0"></asp:Label>
                            </h2>
                            <small>Dari seluruh pesanan dengan status 'Selesai'</small>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card text-white bg-info shadow-sm border-0 h-100">
                        <div class="card-body">
                            <h6 class="card-title text-uppercase fw-bold text-white-50">Total Proyek Selesai</h6>
                            <h2 class="display-6 fw-bold mb-0">
                                <asp:Label ID="lblTotalProyek" runat="server" Text="0"></asp:Label>
                            </h2>
                            <small>Karya yang berhasil diserahkan ke pelanggan</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tabel Rincian Pesanan Selesai -->
            <div class="card shadow-sm border-0">
                <div class="card-body">
                    <h5 class="card-title mb-3">Rincian Transaksi Sukses</h5>
                    <div class="table-responsive">
                        <asp:GridView ID="gvLaporan" runat="server" CssClass="table table-bordered table-hover align-middle"
                            AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="id_pesanan" HeaderText="ID Pesanan" ItemStyle-Width="100px" />
                                <asp:BoundField DataField="tanggal_pesan" HeaderText="Tanggal Selesai (Est)" DataFormatString="{0:dd MMM yyyy}" />
                                <asp:BoundField DataField="nama_pemesan" HeaderText="Nama Pelanggan" />
                                <asp:BoundField DataField="nama_paket" HeaderText="Paket Layanan" />
                                <asp:BoundField DataField="harga" HeaderText="Nilai Transaksi (Rp)" DataFormatString="{0:N0}" />
                            </Columns>
                            <HeaderStyle CssClass="table-light" />
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>