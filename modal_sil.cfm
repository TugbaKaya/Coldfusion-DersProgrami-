<cfset gun = DEcrypt(gun, session.key, session.algorithm, session.encoding ) > 
<cfset saat = DEcrypt(saat, session.key, session.algorithm, session.encoding ) >  
<cfoutput>#gun#<br>#saat#</cfoutput>

<cfquery name="SilinecekDersler" datasource="KOU"> 
	SELECT TOP (30) DersProgrami.Dersid, DersProgrami.Gun, Personel.AdSoyad, Gorevler.Gorev, BolognaKatalog.DersAdi, DersProgrami.Saat
	FROM acilandersler INNER JOIN
	DersProgrami ON acilandersler.Dersid = DersProgrami.Dersid INNER JOIN
	BolognaKatalog ON acilandersler.Katalogid = BolognaKatalog.Katalogid INNER JOIN
	Gorevler INNER JOIN
	Personel ON Gorevler.Gorevid = Personel.Gorevid ON acilandersler.OgrGor = Personel.Kurumid
    WHERE (acilandersler.Bolumid = '0201') AND (acilandersler.Donem = '1617G') AND (acilandersler.Sube = '020110') AND DersProgrami.Gun = 'gun' AND DersProgrami.Saat = 'saat'
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
    	 <select name="SilinecekDers" id="SilinecekDers">
            <cfloop query="SilinecekDersler">
                <option value="#Dersid#">#DersAdi# (#Gorev# #AdSoyad#)</option>
            </cfloop>
        </select>
    </div>
</div>
</cfoutput>