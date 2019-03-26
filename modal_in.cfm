<!---Ders ekle butonuna týklandýðýnda eklenecek derslerin listelendiði dosya--->

<cfquery name="AcikDersler" datasource="KOU">        
   SELECT TOP (30) acilandersler.Dersid, acilandersler.Bolumid, acilandersler.Sube, acilandersler.Donem, acilandersler.Yariyil, BolognaKatalog.DersAdi, 
                   BolognaKatalog.Katalogid, Personel.Kurumid, Personel.AdSoyad, Gorevler.Gorev, acilandersler.OgrTur, acilandersler.DipTur, BolognaKatalog.BolognaKatalog, 
                   BolognaKatalog.DersinDili, BolognaKatalog.KatalogTur, BolognaKatalog.Yariyil AS Expr1, BolognaKatalog.DersTur, BolognaDersSecimTur.SecimTur
   FROM            acilandersler INNER JOIN
                   BolognaKatalog ON acilandersler.Katalogid = BolognaKatalog.Katalogid INNER JOIN
                   Personel ON acilandersler.OgrGor = Personel.Kurumid INNER JOIN
                   Gorevler ON Personel.Gorevid = Gorevler.Gorevid INNER JOIN
                   BolognaDersSecimTur ON BolognaKatalog.DersTur = BolognaDersSecimTur.SecimId
   WHERE           (acilandersler.Bolumid = '0201') AND (acilandersler.Donem = '1617G') AND (acilandersler.Sube = '020110')         
</cfquery>
<cfquery name="personel" datasource="KOU">        
    SELECT Top 30 Kurumid, AdSoyad, Bolumid FROM Personel         
</cfquery>
<cfquery name="donem" datasource="KOU"> 
	SELECT Donemid, DonemAd, Aktif FROM Donem WHERE(Aktif = 1)
</cfquery>
<cfoutput>

<div class="row">
    <div class="col-sm-3">Dersler :</div>
    <div class="col-lg-9">
    	 <select name="SecilenDers" id="SecilenDers">
            <cfloop query="AcikDersler">
                <option value="#Dersid#">#DersAdi# (#Gorev# #AdSoyad#)</option>
            </cfloop>
        </select>
    </div>
</div>

</cfoutput>





