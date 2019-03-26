<!---Ders Programi oluþturma tablosundaki alanlardan birinde deðiþiklik yapýldýðýnda sadece o alaný güncelleyen dosya--->

<cfset EGunum = DEcrypt(gun, session.key, session.algorithm, session.encoding ) > 
<cfset EDersD = DEcrypt(saat, session.key, session.algorithm, session.encoding ) >  
<!---<cfset EDersid = DEcrypt(dersid, session.key, session.algorithm, session.encoding ) >--->

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
    WHERE (acilandersler.Donem = '1617G') AND (acilandersler.Bolumid = '0201') AND (acilandersler.Sube = '020110') 
    and  Gunid = #EGunum# AND DersDilim = #EDersD#
    ORDER BY Gunler.Gunid, DersSaati.DersDilim
</cfquery>         

<cfoutput>
    <cfloop query="dersler" >
    	#DersAdi# (#SecimTur#)<br />#Gorev# #AdSoyad# (#Kurumid#)
        <cfset EGunum = Encrypt(Gunid, session.key, session.algorithm, session.encoding ) > 
		<cfset EDersD = Encrypt(DersDilim, session.key, session.algorithm, session.encoding ) >  
        <cfset Edersid = Encrypt(Dersid, session.key, session.algorithm, session.encoding ) >  
       <button type="button" class="btn btn-outline-danger btn-sm" data-toggle="modal" data-target="##DersSilmeButon" name="DersSil_#EGunum#_#EDersD#_#Edersid#" id="DersSil" >Sil</button><hr />
    </cfloop>
</cfoutput>
<!---Ana sayfada(DersProgrami.cfm) var olan JavaScript kodu bu sayfa da tekrar oluþturuldu, çünkü tablonun içeriði güncellendikten sonra ana sayfa da olan javaScript kodu ile guncelle sayfasý baðlantý kuramamaktadýr.--->
<script type="text/javascript">
	$(function() 
	{  
		$("[name^=DersSil]").click(function()
		{			
			var veriler1 = $(this).attr("name").split("_");
			$("#tiklanan3").val(veriler1[1]);
			$("#tiklanan4").val(veriler1[2]);
			$("#tiklanan5").val(veriler1[3]);			
		});
   });
</script>