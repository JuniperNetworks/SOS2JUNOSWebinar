<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:junos="http://xml.juniper.net/junos/*/junos" xmlns:xnm="http://xml.juniper.net/xnm/1.1/xnm" xmlns:ext="http://xmlsoft.org/XSLT/namespace" xmlns:jcs="http://xml.juniper.net/junos/commit-scripts/1.0" xmlns:func="http://exslt.org/functions" xmlns:dyn="http://exslt.org/dynamic" xmlns:local="http://xml.juniper.net/local" extension-element-prefixes="dyn func">
	<xsl:import href="../import/junos.xsl"/>
	
	<!-- ma ke a connection to the local device -->
	<xsl:variable name="connection" select="jcs:open()"/>
	
	<xsl:template match="/">
		<!-- RPC to excecute -->
		<xsl:variable name="command-rpc">
			<rpc>
				<get-interface-information>
				</get-interface-information>
			</rpc>
		</xsl:variable>
		
		<!-- run command and collect results -->
		<xsl:variable name="command-results" select="jcs:execute($connection,$command-rpc)"/>
		
		<!-- process results -->
		<op-script-results>
			<output>
				<xsl:value-of select="jcs:printf('%-15s %-25s %-11s %-17s %-5s\n', 'Name', 'IP Address','Zone','MAC','State')"/>
				
				<!-- end processing -->
				<!-- show results -->
				<!-- show header row -->
			</output>
		</op-script-results>
	</xsl:template>
</xsl:stylesheet>
