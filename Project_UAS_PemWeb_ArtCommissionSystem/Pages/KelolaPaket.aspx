<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="KelolaPaket.aspx.cs" Inherits="Project_UAS_PemWeb_ArtCommissionSystem.Pages.KelolaPaket" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Kelola Paket Layanan - Art Commission</title>
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
            <div class="row">
                <!-- Bagian Kiri: Form Tambah Data (CREATE) -->
                <div class="col-md-4 mb-4">
                    <div class="card shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title text-primary mb-3">Tambah Paket Baru</h5>
                            
                            <div class="mb-3">
                                <label class="form-label">Nama Paket</label>
                                <asp:TextBox ID="txtNamaPaket" runat="server" CssClass="form-control" placeholder="Contoh: Lineart"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Deskripsi</label>
                                <asp:TextBox ID="txtDeskripsi" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" placeholder="Detail layanan..."></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Harga (Rp)</label>
                                <asp:TextBox ID="txtHarga" runat="server" TextMode="Number" CssClass="form-control" placeholder="Contoh: 50000"></asp:TextBox>
                            </div>
                            
                            <div class="d-grid">
                                <asp:Button ID="btnSimpan" runat="server" Text="Simpan Paket" CssClass="btn btn-success" OnClick="btnSimpan_Click" />
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Bagian Kanan: Tabel Data (READ, UPDATE, DELETE) -->
                <div class="col-md-8">
                    <div class="card shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title text-primary mb-3">Daftar Paket Layanan</h5>
                            
                            <!-- Komponen GridView bawaan ASP.NET untuk CRUD Otomatis -->
                            <div class="table-responsive">
                                <asp:GridView ID="gvPaketLayanan" runat="server" CssClass="table table-bordered table-hover align-middle" 
                                    AutoGenerateColumns="False" DataKeyNames="id_paket"
                                    OnRowEditing="gvPaketLayanan_RowEditing" 
                                    OnRowCancelingEdit="gvPaketLayanan_RowCancelingEdit" 
                                    OnRowUpdating="gvPaketLayanan_RowUpdating" 
                                    OnRowDeleting="gvPaketLayanan_RowDeleting">
                                    
                                    <Columns>
                                        <asp:BoundField DataField="id_paket" HeaderText="ID" ReadOnly="True" ItemStyle-Width="50px" />
                                        <asp:BoundField DataField="nama_paket" HeaderText="Nama Paket" />
                                        <asp:BoundField DataField="deskripsi" HeaderText="Deskripsi" />
                                        <asp:BoundField DataField="harga" HeaderText="Harga (Rp)" DataFormatString="{0:N0}" />
                                        
                                        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" 
                                            ControlStyle-CssClass="btn btn-sm btn-outline-primary me-1 mb-1" 
                                            CancelText="Batal" DeleteText="Hapus" EditText="Edit" UpdateText="Simpan" />
                                    </Columns>
                                    <HeaderStyle CssClass="table-light" />
                                </asp:GridView>
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