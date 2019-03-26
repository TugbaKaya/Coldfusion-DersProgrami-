<!---DersProgrami.cfm dosyasýndan gelen þifreli metinlerin çözümlenmesi--->
<cfset gun = DEcrypt(gun, session.key, session.algorithm, session.encoding ) > 
<cfset saat = DEcrypt(saat, session.key, session.algorithm, session.encoding ) >     

<cfquery datasource="kou" name="dersvarmi">
    select Dersid from DersProgrami where
     Dersid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Dersid#" /> AND
     Gun = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#gun#" /> AND 
     Saat = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#saat#" />
</cfquery>

<cfif dersvarmi.recordcount gt 0 >

<!---Modal--- Veri tabanýnda var olan kayýt tekrar kaydedilmek istendiðinde verilen toast mesajý --->
<div class="toast" role="alert" aria-live="assertive" aria-atomic="true"  data-delay="5000" >
    <div class="toast-header">
        <strong class="mr-auto">Ders Kayýt Ýþlemi</strong>
        <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <div class="toast-body">
        Ayný kayýt bulunmaktadýr!
    </div>
</div>
<script>
	$('.toast').toast('show');
</script> 
<!---Veri tabanýna derslerin eklendiði alan--->
<cfelse>
	<cfquery result="ders" datasource="kou" name="dersler">
        INSERT INTO DersProgrami 
         (Dersid, gun, saat) VALUES 
         (<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Dersid#" />,
         <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#gun#" />,
         <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#saat#" />
         ) 
    </cfquery>
    
<!---DersProgramý tablosuna kayýt eklendiðinde ekraný çýkan toast mesajý--->
<div class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-delay="5000" >
    <div class="toast-header">
        <strong class="mr-auto">Ders Kayýt Ýþlemi</strong>
        <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <div class="toast-body">
       Kayýt baþarýyla girilmiþtir!
    </div>
</div>
<script>
	$('.toast').toast('show');
</script> 

</cfif>

