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
        <xsl:for-each select="$command-results/physical-interface">
            <!-- check for banned interfaces -->
            <xsl:choose>
                <xsl:when test="./if-type = 'Adaptive-Services'">
                    <!-- do nothing this is annoying -->
                </xsl:when>
                <xsl:otherwise>
                    <!-- now we are itterating through each element in interface information -->
                    <xsl:variable name="name" select="./name"/>
                    <xsl:variable name="state" select="./oper-status"/>
                    <xsl:variable name="current-physical-address">
                        <xsl:choose>
                            <xsl:when test="./current-physical-address != ''">
                                <xsl:value-of select="./current-physical-address"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="concat('N/A','')"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
 
                    <!--<xsl:value-of select="jcs:printf('%-15s %-25s %-11s %-17s %-5s\n',$name,'N/A','N/A','N/A',$state)"/>-->
                    <xsl:for-each select="./logical-interface">
                        <xsl:choose>
                            <xsl:when test="./name = 'lo0.16384'">
                                <!-- do nothing this is annoying -->
                            </xsl:when>
                            <xsl:when test="./name = 'lo0.16385'">
                                <!-- do nothing this is annoying -->
                            </xsl:when>
                            <xsl:when test="./name = 'lo0.32768'">
                                <!-- do nothing this is annoying -->
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:variable name="logical-name" select="./name"/>
                                <xsl:variable name="logical-interface-zone-name" select="./logical-interface-zone-name"/>
                                <xsl:variable name="ip-address" select="./address-family/interface-address/ifa-local"/>
                                <xsl:variable name="mask">
                                    <xsl:choose>
                                        <xsl:when test="./address-family/interface-address/ifa-destination != ''">
                                            <xsl:choose>
                                                <xsl:when test="substring-after(./address-family/interface-address/ifa-destination,'/')">
                                                    <xsl:value-of select="concat('/',substring-after(./address-family/interface-address/ifa-destination,'/'))"/>
                                                </xsl:when>
                                                <xsl:otherwise></xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="concat('','')"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>
                                <xsl:variable name="full-address">
                                    <xsl:choose>
                                        <xsl:when test="$ip-address != ''">
                                            <xsl:value-of select="concat($ip-address,$mask)"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="concat('N/A','')"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>
                                <xsl:value-of select="jcs:printf('%-15s %-25s %-11s %-17s %-5s\n',$logical-name,$full-address,$logical-interface-zone-name,$current-physical-address,$state)"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        <!-- itterate through the logical interface nodes -->
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
        <!-- end processing -->
            <!-- show results -->
            <!-- show header row -->
            </output>
        </op-script-results>
    </xsl:template>
</xsl:stylesheet>
