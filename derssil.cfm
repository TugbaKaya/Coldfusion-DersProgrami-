<!---Veri Tabanýndan Ders Silme Dosyasý--->
<cfset Dersid = DEcrypt(Dersid, session.key, session.algorithm, session.encoding ) >
<cfset gun = DEcrypt(gun, session.key, session.algorithm, session.encoding ) > 
<cfset saat = DEcrypt(saat, session.key, session.algorithm, session.encoding ) >

	<cfquery result="ders" datasource="kou" name="dersler">
        DELETE FROM DersProgrami WHERE Dersid = #Dersid# AND gun = #gun# AND saat = #saat#
    </cfquery>
  
<div class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-delay="5000" >
    <div class="toast-header">
        <strong class="mr-auto">Ders Silme Ýþlemi</strong>
        <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <div class="toast-body">
       Ders Silme Ýþlemi Gerçekleþmiþtir! <hr />
    </div>
</div>
<script>
	$('.toast').toast('show');
</script> 



