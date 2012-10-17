/* Machine Crafted with Care (tm) by slaxWriter */
version 1.0;

ns junos = "http://xml.juniper.net/junos/*/junos";
ns xnm = "http://xml.juniper.net/xnm/1.1/xnm";
ns ext = "http://xmlsoft.org/XSLT/namespace";
ns jcs = "http://xml.juniper.net/junos/commit-scripts/1.0";
ns func extension = "http://exslt.org/functions";
ns dyn extension = "http://exslt.org/dynamic";
ns local = "http://xml.juniper.net/local";

import "../import/junos.xsl";
var $connection = jcs:open();

match / {
  var $command-rpc = "";
  var $command-results = "";
  /* process results */
  /* end processing */

<op-script-results> {
    /* show results */
    }
}