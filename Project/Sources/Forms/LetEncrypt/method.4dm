
C_LONGINT:C283($formEvent_l)
$formEvent_l:=Form event code:C388

Case of 
	: ($formEvent_l=On Load:K2:1)
		
		ARRAY TEXT:C222(domains_at; 0)
		C_BOOLEAN:C305(use_staging_b)
		C_TEXT:C284(vs_email)
		
		OBJECT SET PLACEHOLDER:C1295(*; "vs_email"; "mailto:email@domain.com")
		
		use_staging_b:=True:C214
		
End case 
