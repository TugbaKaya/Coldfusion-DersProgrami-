<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-9" />
<title>Başlıksız Belge</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    
</head>

<body>

<cfquery name="dersler" datasource="kou">
	SELECT acilandersler.Dersid, acilandersler.Bolumid, acilandersler.Sube, acilandersler.Donem, acilandersler.Yariyil, BolognaKatalog.DersAdi, BolognaKatalog.Katalogid, 
         Personel.Kurumid, Personel.AdSoyad, Gorevler.Gorev, Bolumler.BolumAd, FakulteKod.FakAd, FakTurKod.FakTurAd, Gunler.GunAd, Gunler.Gunid, 
         DersSaati.DersDilim, DersSaati.DersBaslangicSaati, acilandersler.OgrTur, acilandersler.DipTur, BolognaKatalog.BolognaKatalog, BolognaKatalog.DersinDili, 
         BolognaKatalog.KatalogTur, BolognaKatalog.Yariyil AS Expr1, BolognaKatalog.DersTur, BolognaDersSecimTur.SecimTur
		 FROM acilandersler INNER JOIN
         BolognaKatalog ON acilandersler.Katalogid = BolognaKatalog.Katalogid INNER JOIN
         Personel ON acilandersler.OgrGor = Personel.Kurumid INNER JOIN
         Gorevler ON Personel.Gorevid = Gorevler.Gorevid INNER JOIN
         Bolumler ON acilandersler.Bolumid = Bolumler.Bolumid INNER JOIN
         FakulteKod ON Bolumler.Fakulteid = FakulteKod.Fakulteid INNER JOIN
         FakTurKod ON FakulteKod.FakTur = FakTurKod.FakTur INNER JOIN
         DersProgrami ON acilandersler.Dersid = DersProgrami.Dersid INNER JOIN
         Gunler ON DersProgrami.Gun = Gunler.Gunid INNER JOIN
         DersSaati ON DersProgrami.Saat = DersSaati.DersSaatid INNER JOIN
         BolognaDersSecimTur ON BolognaKatalog.DersTur = BolognaDersSecimTur.SecimId
    WHERE (acilandersler.Donem = '1617G') AND (acilandersler.Bolumid = '0201')<!--- AND (acilandersler.Sube = '020110') --->
    ORDER BY Gunler.Gunid, DersSaati.DersDilim
</cfquery>

<cfquery name="dilimler" datasource="kou" cachedwithin="#createtimespan(0,1,0,0)#" >
	SELECT DersBaslangicSaati as dbs, DersDilim as dd
	FROM dbo.DersSaati
</cfquery>

<cfquery name="gunler" datasource="kou" cachedwithin="#createtimespan(0,1,0,0)#" >
	SELECT Gunid, GunAd
	FROM dbo.Gunler
</cfquery>

<div class="container">

<div class="row"><div id="yanit" ></div></div>
				<!---Ders Programi Tablosu--->
<table border="1" cellpadding="25" cellspacing="3" bgcolor="#000000">
    <tr>
        <th bgcolor="#5c8aff">SAAT</th>
        <th bgcolor="#5c8aff">PAZARTESİ</th>
        <th bgcolor="#5c8aff">SALI</th>
        <th bgcolor="#5c8aff">ÇARŞAMBA</th>
        <th bgcolor="#5c8aff">PERŞEMBE</th>
        <th bgcolor="#5c8aff">CUMA</th>
        <th bgcolor="#5c8aff">CUMARTESİ</th>
        <th bgcolor="#5c8aff">PAZAR</th>
    </tr>

<cfoutput>
    <cfloop query="dilimler">
    	<cfset DersD = dd >
      	<cfset DersBS = dbs >
			<tr style="font-size:10px" >
            	<td bgcolor="b8ccff">#DersBS#</td>
			    <cfloop query="gunler"> 
					<cfset Gunum = Gunid >   
                        <cfquery name="DersiGetir" dbtype="query">
                            select * from dersler where Gunid = #Gunum# AND DersDilim = #DersD#
                        </cfquery>                        
                    <td bgcolor="e5edff">  
                        <cfset EGunum = Encrypt(Gunum, session.key, session.algorithm, session.encoding ) > 
                        <cfset EDersD = Encrypt(DersD, session.key, session.algorithm, session.encoding ) > 
                            <div class="row">
                            	<div id="divim_#EGunum#_#EDersD#">
                           			 <cfloop query="DersiGetir" >
                                     <cfset DersID = Dersid >
                                     <cfset EDersid = Encrypt(DersID, session.key, session.algorithm, session.encoding ) >
                                     #DersAdi# (#SecimTur#)<br />#Gorev# #AdSoyad# (#Kurumid#)
                                     <button type="button" class="btn btn-outline-danger btn-sm" data-toggle="modal" data-target="##DersSilmeButon" name="DersSil_#EGunum#_#EDersD#_#EDersid#" id="DersSil" >Sil</button><hr />
                                     </cfloop>
                            	</div>
                            </div>
                          <button type="button" class="btn btn-outline-success btn-sm" data-toggle="modal" data-target="##DersKaydet" name="DersEkle_#EGunum#_#EDersD#" id="DersEkle" >Ders Ekle</button><br /><hr />
                    </td>
			    </cfloop>
        	</tr>
    </cfloop>
</cfoutput>

</table>

<!---DersEkle butonundaki name alanındaki parçaların verilerin tutulduğu input--->
<input type="hidden" id="tiklanan1" name="tiklanan1" value="" />
<input type="hidden" id="tiklanan2" name="tiklanan2" value="" />

<!-- Modal --><!---Ders ve Öğretim elemanı seçimi--->

<div class="modal fade" id="DersKaydet" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Ders Seçimi</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <cfinclude template="modal_in.cfm" >
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">İptal</button>
        <button type="button" class="btn btn-primary" id="Kaydet" >Kaydet</button>
      </div>
    </div>
  </div>
</div>

<!---Derssilme butonundaki name alanındaki parçaların verilerin tutulduğu input--->
<input type="hidden" id="tiklanan3" name="tiklanan3" value="" />
<input type="hidden" id="tiklanan4" name="tiklanan4" value="" />
<input type="hidden" id="tiklanan5" name="tiklanan5" value="" />

<!-- Modal --><!---Silmek İstediğinizden Emin Misiniz?--->

<div class="modal fade" id="DersSilmeButon" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Bilgi(!)</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       Silmek İstediğinizden Emin Misiniz?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hayır</button>
        <button type="button" class="btn btn-primary" id="Sil" >Evet</button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
	$(function() 
	{		
		<!--- verileri kaydet butonunun click lenmesi --->
		$("#Kaydet").click(function()
		{			
			
			var Dersid = $("#SecilenDers").val();
			var gun = $("#tiklanan1").val();
			var saat = $("#tiklanan2").val();
			
			$.ajax({
				type		: "POST",
				url			: "DersProgramiKaydet.cfm",
				data		: "Dersid=" + Dersid + "&gun=" + gun + "&saat=" + saat,
				beforeSend	: function(){$("div#yanit").html('<div align="center"><img src="loader.gif" width="200" style="margin: auto;"></div>').show();},
				error		: function(){$("div#yanit").html('Hata.. İşlem sayfasına erişilemedi\n Lütfen tekrar deneyiniz...').show();},
				success 	: function(Sonuc) {$('div#divim_' + gun + '_' + saat).load("dersguncelle.cfm?Dersid=" + Dersid + "&gun=" + gun + "&saat=" + saat);$("div#yanit").html(Sonuc).show(100);}
				
			});
			
			$('#DersKaydet').modal('toggle');
			
		});  
		
		<!---Ders silme butonunun clicklenmesi--->
		$("#Sil").click(function()
		{			
		
			var Dersid = $("#tiklanan5").val();
			var gun = $("#tiklanan3").val();
			var saat = $("#tiklanan4").val();			
			
			$.ajax({
				type		: "POST",
				url			: "derssil.cfm",
				data		: "Dersid=" + Dersid + "&gun=" + gun + "&saat=" + saat,
				beforeSend	: function(){$("div#yanit").html('<div align="center"><img src="loader.gif" width="200" style="margin: auto;"></div>').show();},
				error		: function(){$("div#yanit").html('Hata.. İşlem sayfasına erişilemedi\n Lütfen tekrar deneyiniz...').show();},
				success 	: function(Sonuc) {$('div#divim_' + gun + '_' + saat).load("dersguncelle.cfm?gun=" + gun + "&saat=" + saat + "&dersid=" + Dersid);$("div#yanit").html(Sonuc).show(100);}
				
			});
			
			$('#DersSilmeButon').modal('toggle');
			
		}); 
		  
		<!---Ders Ekle Butonu Name alanı parçalama--->
		$("[name^=DersEkle]").click(function()
		{			
			var veriler = $(this).attr("name").split("_");
			$("#tiklanan1").val(veriler[1]);
			$("#tiklanan2").val(veriler[2]);			
		});
		<!---Ders Sil Butonu Name alanı parçalama--->
		$("[name^=DersSil]").click(function()
		{			
			var veriler1 = $(this).attr("name").split("_");
			$("#tiklanan3").val(veriler1[1]);
			$("#tiklanan4").val(veriler1[2]);
			$("#tiklanan5").val(veriler1[3]);			
		});
				
	});
</script>

</body>
</html>
