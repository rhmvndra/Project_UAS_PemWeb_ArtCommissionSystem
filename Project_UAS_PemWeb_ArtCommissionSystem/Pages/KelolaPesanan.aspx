<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="KelolaPesanan.aspx.cs" Inherits="Project_UAS_PemWeb_ArtCommissionSystem.Pages.KelolaPesanan" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Daftar Pesanan - Art Commission</title>
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
            <div class="card shadow-sm border-0">
                <div class="card-body">
                    <h4 class="card-title text-primary mb-4">Daftar Pesanan Masuk</h4>
                    
                    <div class="table-responsive">
                        <!-- GridView untuk menampilkan data JOIN dari tabel Pesanan dan Paket_Layanan -->
                        <asp:GridView ID="gvPesanan" runat="server" CssClass="table table-bordered table-hover align-middle"
                            AutoGenerateColumns="False" DataKeyNames="id_pesanan"
                            OnRowCommand="gvPesanan_RowCommand">
                            <Columns>
                                <asp:BoundField DataField="id_pesanan" HeaderText="ID" ItemStyle-Width="40px" />
                                <asp:BoundField DataField="tanggal_pesan" HeaderText="Tanggal" DataFormatString="{0:dd MMM yyyy HH:mm}" />
                                <asp:BoundField DataField="nama_pemesan" HeaderText="Pemesan" />
                                <asp:BoundField DataField="kontak" HeaderText="Kontak" />
                                <asp:BoundField DataField="nama_paket" HeaderText="Layanan" />
                                <asp:BoundField DataField="catatan" HeaderText="Catatan" />
                                
                                <!-- Template untuk Status agar warnanya bisa disesuaikan -->
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class="badge bg-<%# Eval("status").ToString() == "Pending" ? "danger" : (Eval("status").ToString() == "Diproses" ? "warning text-dark" : "success") %>">
                                            <%# Eval("status") %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <!-- Tombol Aksi Dinamis -->
                                <asp:TemplateField HeaderText="Aksi">
                                    <ItemTemplate>
                                        <asp:Button ID="btnProses" runat="server" Text="Terima Pesanan" CommandName="ProsesPesanan" CommandArgument='<%# Eval("id_pesanan") %>' CssClass="btn btn-sm btn-outline-warning mb-1" Visible='<%# Eval("status").ToString() == "Pending" %>' />
                                        <asp:Button ID="btnSelesai" runat="server" Text="Tandai Selesai" CommandName="SelesaiPesanan" CommandArgument='<%# Eval("id_pesanan") %>' CssClass="btn btn-sm btn-outline-success mb-1" Visible='<%# Eval("status").ToString() == "Diproses" %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
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