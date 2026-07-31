<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CekPesanan.aspx.cs" Inherits="Project_UAS_PemWeb_ArtCommissionSystem.CekPesanan" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Cek Status Pesanan - Art Commission</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
    <form id="form1" runat="server">
        <!-- Navbar Publik -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
            <div class="container">
                <a class="navbar-brand fw-bold" href="Default.aspx">🎨 Art Studio</a>
                <div class="d-flex">
                    <a href="Default.aspx" class="btn btn-outline-light btn-sm me-2">Katalog Layanan</a>
                    <a href="Pages/Login.aspx" class="btn btn-light btn-sm">Login Admin</a>
                </div>
            </div>
        </nav>

        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card shadow-sm border-0 mb-4">
                        <div class="card-body p-4 text-center">
                            <h4 class="card-title fw-bold mb-3">Cek Status Pesanan Anda</h4>
                            <p class="text-muted mb-4">Masukkan nomor WhatsApp atau Email yang Anda gunakan saat memesan komisi.</p>
                            
                            <div class="input-group input-group-lg mb-3">
                                <asp:TextBox ID="txtKontakPencarian" runat="server" CssClass="form-control" placeholder="Contoh: 0812xxxx atau email@domain.com"></asp:TextBox>
                                <asp:Button ID="btnCari" runat="server" Text="Cari Pesanan" CssClass="btn btn-primary" OnClick="btnCari_Click" />
                            </div>
                        </div>
                    </div>

                    <!-- Tempat Menampilkan Hasil Pencarian -->
                    <div class="card shadow-sm border-0" id="panelHasil" runat="server" visible="false">
                        <div class="card-header bg-success text-white">
                            <h5 class="mb-0">Hasil Pencarian</h5>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <asp:GridView ID="gvHasilPencarian" runat="server" CssClass="table table-hover align-middle mb-0"
                                    AutoGenerateColumns="False" GridLines="None">
                                    <Columns>
                                        <asp:BoundField DataField="tanggal_pesan" HeaderText="Tanggal" DataFormatString="{0:dd MMM yyyy}" />
                                        <asp:BoundField DataField="nama_paket" HeaderText="Layanan" />
                                        <asp:BoundField DataField="catatan" HeaderText="Catatan" />
                                        
                                        <asp:TemplateField HeaderText="Status">
                                            <ItemTemplate>
                                                <span class="badge bg-<%# Eval("status").ToString() == "Pending" ? "danger" : (Eval("status").ToString() == "Diproses" ? "warning text-dark" : "success") %> fs-6">
                                                    <%# Eval("status") %>
                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="table-light" />
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Pesan Jika Tidak Ditemukan -->
                    <div id="panelTidakDitemukan" runat="server" visible="false" class="alert alert-warning text-center">
                        Data pesanan tidak ditemukan untuk kontak tersebut. Pastikan Anda memasukkan kontak yang benar.
                    </div>

                </div>
            </div>
        </div>
    </form>
</body>
</html>