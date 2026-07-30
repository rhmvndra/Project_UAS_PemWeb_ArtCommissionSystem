<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormPesanan.aspx.cs" Inherits="Project_UAS_PemWeb_ArtCommissionSystem.Pages.FormPesanan" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Formulir Pemesanan - Art Commission</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
    <form id="form1" runat="server">
        <!-- Navbar Publik -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
            <div class="container">
                <a class="navbar-brand fw-bold" href="../Default.aspx">🎨 Art Studio</a>
                <a href="../Default.aspx" class="btn btn-outline-light btn-sm">Batal / Kembali</a>
            </div>
        </nav>

        <div class="container mt-5 mb-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card shadow-sm border-0">
                        <div class="card-header bg-primary text-white py-3">
                            <h4 class="mb-0">Formulir Pemesanan Komisi</h4>
                        </div>
                        <div class="card-body p-4">
                            
                            <!-- Info Paket yang Dipilih -->
                            <div class="alert alert-info mb-4">
                                <h5>Anda akan memesan: <asp:Label ID="lblNamaPaket" runat="server" CssClass="fw-bold"></asp:Label></h5>
                                <p class="mb-0">Harga: <asp:Label ID="lblHargaPaket" runat="server" CssClass="fw-bold text-success"></asp:Label></p>
                            </div>

                            <!-- Input Form -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">Nama Pemesan</label>
                                <asp:TextBox ID="txtNamaPemesan" runat="server" CssClass="form-control" placeholder="Masukkan nama Anda atau nama pena"></asp:TextBox>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label fw-bold">Kontak (Email / WhatsApp)</label>
                                <asp:TextBox ID="txtKontak" runat="server" CssClass="form-control" placeholder="Contoh: 0812xxxx atau email@domain.com"></asp:TextBox>
                            </div>
                            
                            <div class="mb-4">
                                <label class="form-label fw-bold">Catatan / Referensi Karakter</label>
                                <asp:TextBox ID="txtCatatan" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" placeholder="Jelaskan pose, pakaian, atau link referensi gambar karakter Anda di sini..."></asp:TextBox>
                            </div>
                            
                            <!-- Field tersembunyi untuk menyimpan ID Paket -->
                            <asp:HiddenField ID="hfIdPaket" runat="server" />

                            <div class="d-grid">
                                <asp:Button ID="btnKirimPesanan" runat="server" Text="Kirim Pesanan" CssClass="btn btn-success btn-lg" OnClick="btnKirimPesanan_Click" />
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>