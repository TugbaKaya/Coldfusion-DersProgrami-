<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Başlıksız Belge</title>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    
</head>

<body>
<div class="container" >
    <div class="row">
    	<cfoutput>
        	<cfquery name="bolum" datasource="KOU">        
                SELECT BolumAd, Bolumid FROM Bolumler ORDER BY BolumAd     
            </cfquery>
            <div class="col-sm-3">Bolüm: </div>
            <div class="col-sm-9"> 
            	<select class="custom-select" name="Bolumid" id="bolumid">
                	<cfloop query="bolum">
                    	<option value="#Bolumid#">#BolumAd#</option>
                	</cfloop>
            	</select>
            </div>
        
            <cfquery name="dersler" datasource="KOU">        
                SELECT TOP 50 DersAdi,Katalogid FROM BolognaKatalog ORDER BY DersAdi        
            </cfquery>
            <div class="col-sm-3">Dersler :</div>
            <div class="col-sm-9">
            	<select class="custom-select" name="Katalogid" id="katalogid" >
                	<cfloop query="dersler">
                    	<option value="#Katalogid#">#DersAdi#</option>
                	</cfloop>
            	</select> 
            </div>
           
           <cfquery name="Personel" datasource="KOU">        
                SELECT Top 30 Kurumid, AdSoyad FROM Personel      
            </cfquery>
            <div class="col-sm-3">Öğretim Elemanları: </div>
            <div class="col-sm-9"> 
            	<select class="custom-select" name="Kurumid" id="kurumid" >
                	<cfloop query="personel">
                    	<option value="#Kurumid#">#AdSoyad#</option>
                	</cfloop>
            	</select>
            </div>
             
            <cfquery name="donem" datasource="KOU">        
                SELECT Top 30 DonemAd, Donemid FROM Donem ORDER BY DonemAd      
            </cfquery> 
            <div class="col-sm-3">Dönem: </div>
            <div class="col-sm-9"> 
            	<select class="custom-select" name="Donemid" id="donemid" >
                	<cfloop query="donem">
                    	<option value="#Donemid#">#DonemAd#</option>
                	</cfloop>
            	</select>
            </div>
            
            <div class="col-12">
                <button type="button" name="kayit" class="btn btn-primary" id="kayit" >Kaydet</button>
            </div>
        </cfoutput>
    </div>
</div>

<div id="dersler"></div>

<script type="text/javascript">

	$(function() 
	{
		$("#kayit").click(function()
		{			
			var bolumid = $("#Bolumid").val();
			var katalogid = $("#Katalogid").val();
			var Kurumid = $("#Kurumid").val();
			var donemid = $("#Donemid").val();
			
			$.ajax({
				type		: "POST",
				url			: "acilandersler.cfm",
				data		: "Bolumid=" + bolumid + "&Katalogid=" + katalogid + "&OgrGor=" + Kurumid +"&Donem=" + donemid,
				beforeSend	: function(){$("div#yanit").html('<div align="center"><img src="loader.gif" width="200" style="margin: auto;"></div>').show();},
				error		: function(){$("div#yanit").html('Hata.. İşlem sayfasına erişilemedi\n Lütfen tekrar deneyiniz...').show();},
				success 	: function(Sonuc) {<!---$('div#divim_' + gun + '_' + saat).load("dersguncelle.cfm?Dersid=" + Dersid + "&gun=" + gun + "&saat=" + saat);--->$("div#dersler").html(Sonuc).show(100);}
				
			});
			
			$('#exampleModal').modal('toggle');
			
		}); 
	});
</script>

</body>
</html>