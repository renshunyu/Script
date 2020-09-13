#/bin/sh
echo '##########################################################################'
function fPro()
{
  firsttag=`svn log $1 --stop-on-copy -q|grep -v '\-\-\-\-'|awk '{print $1}'|awk -F'r' '{print $2}'|sort -n|awk 'NR==1'`;
  op=`svn log -r$firsttag $1 --stop-on-copy --verbose|grep products|awk -F' '  '{print $4}'|awk -F':'  '{print $1}'` ;
  opo=http://10.1.198.30/svn/UAPPROGRAM$op;
  #echo $opo
  if [ `echo $opo|grep /program/|wc -l` -eq 1 ];then
  echo "$firsttag $opo";
  else
  echo `fPro $opo` ;
  fi
  return 0

}
echo '##########################################################################'


#==================================
#============
echo '<?xml version="1.0" encoding="UTF-8"?>' >duibi.html
echo '<html>' >>duibi.html
echo ' <head>' >>duibi.html
echo '    <title>对比</title>' >>duibi.html
echo '  </head>' >>duibi.html
echo '  <body>' >>duibi.html
echo '    <h1>对比指定版本program和release的提交记录</h1>' >>duibi.html
echo '	<!--***************************************************************************************************************-->' >>duibi.html
echo "    <p><strong>$1</strong></p>" >>duibi.html
echo "    <p><strong>`date`</strong></p>" >>duibi.html
echo '	<!--***************************************************************************************************************-->' >>duibi.html
#echo '    <h3>目录：</h3>' >>duibi.html
#============
#==================================




#exit 1
aiiappath='http://10.1.198.30/svn/UAPPROGRAM/products/aisiac01'

if [ ! -n "$1" ]; then
	reno=aisiav04r04c02_20180509
else
	reno=$1
fi
echo $reno
release=`svn list $aiiappath/release/$reno`

echo '目录：'
biaoti=1
for i in $release
do
echo '	'$biaoti'. '$i
#==================================
#================
#echo "    <p class='index'>$biaoti、$i</p>" >>duibi.html
#================
#==================================
biaoti=$[ biaoti + 1 ]
done
echo
echo
echo
echo '详细：'
#==================================
#================
echo '<h3>详细：</h3>' >>duibi.html
#================
#==================================
biaoti=1
for i in $release
do
	echo $biaoti'. '$i
	rp=$aiiappath/release/$reno/$i
	echo '  '$rp
	or=`fPro $rp|awk '{print $1}'`
	#or=`svn info $aiiappath/release/$reno/$i|awk -F'Last Changed Rev: ' 'NR%10==8{print $2}'`
	echo '  '$or
        sourcepath=`fPro $rp|awk '{print $2}'`
       
	nr=`svn info $aiiappath|awk -F'Last Changed Rev: ' 'NR%10==8{print $2}'`
	echo '  '$nr

	commitnum=`svn log -r$or:$nr $sourcepath|wc -l`
        iproject=`echo $i|sed "s/\///g"`
	if [ $commitnum -gt 1 ];then
        	echo '  '主干版本$i有过提交记录
			                #==================================
				#================
                echo "    <table border=0 cellpadding=0 cellspacing=0 width=1175 style='border-collapse:collapse;table-layout:fixed;width:882pt'>" >>duibi.html
                echo "      <col width=69 style='mso-width-source:userset;mso-width-alt:2208;width:52pt'>" >>duibi.html
                echo "      <col width=309 style='mso-width-source:userset;mso-width-alt:9888;width:232pt'>" >>duibi.html
                echo "      <col width=437 style='mso-width-source:userset;mso-width-alt:13984;width:328pt'>" >>duibi.html
                echo "      <col width=72 span=5 style='width:54pt'>" >>duibi.html
                echo "      <tr height=18 style='height:13.5pt'>" >>duibi.html
                echo "       <td class=tdclass height=18 align=left width=69 style='height:13.5pt;width:52pt'>${biaoti}、</td>" >>duibi.html
                echo "       <td class=tdclass width=309 style='width:232pt'><a href=\"javascript:openShutManager('${iproject}detail');\">${iproject}</a></td>" >>duibi.html
                echo "       <td class=tdclass colspan=6 width=797 style='mso-ignore:colspan;width:598pt'><span class= 'detailisupdate'>主干版本$i有过提交记录</span></td>" >>duibi.html
                echo "      </tr>" >>duibi.html
                echo "    </table>" >>duibi.html
                #echo "  <p>${biaoti}、<a href=\"javascript:openShutManager('${iproject}detail');\">${iproject}</a><span class= 'detailisupdate'>主干版本$i有过提交记录</span></p>" >>duibi.html
		echo "	<div id=${iproject}detail ondblclick=\"javascript:openShutManager('${iproject}detail');\" style=\"display: none;\">" >>duibi.html
                echo "	  <div>" >>duibi.html
                echo "	    <p>svnurl:http://10.1.198.30/svn/UAPPROGRAM/products/aisiac01/program/$i</p>" >>duibi.html
                echo "	    <table border=0 cellpadding=0 cellspacing=0 width=951 style='border-collapse: collapse;table-layout:fixed;width:715pt'>" >>duibi.html
                echo "		  <colgroup>" >>duibi.html
                echo "            <col width="8%" />" >>duibi.html
                echo "            <col width="38%" />" >>duibi.html
                echo "			<col width="12%" />" >>duibi.html
                echo "			<col width="42%" />" >>duibi.html
                echo "          </colgroup>" >>duibi.html
                echo "		  <tbody>" >>duibi.html
                echo "	      <tr>" >>duibi.html
                echo "		    <td class=tablehead>svn版本号</td>" >>duibi.html
                echo "		    <td class=tablehead>提交时间</td>" >>duibi.html
                echo "		    <td class=tablehead>提交人</td>" >>duibi.html
                echo "		    <td class=tablehead>提交说明</td>" >>duibi.html
                echo "		  </tr>" >>duibi.html
                #================
				#==================================
		echo '	'$sourcepath
		svn log -r$or:$nr $sourcepath|awk '{print "	"$0}'
		        #==================================
				#================
                #svn log -r$or:$nr $sourcepath|grep -v '\-\-\-\-\-\-\-\-\-\-\-\-'|grep -v '^$'|awk -F'|' '{if(NF==4){if(NR!=1){print "</tr>"}print "  <tr><td class=tablerow>"$1"</td><td class=tablerow>"$3"</td><td class=tablerow>"$2"</td>"}else{print "<td class=tablerow>"$0"</td>"}}' >>duibi.html
                #if [ `tail -n 1 duibi.html |grep '</tr>'|wc -l` -eq 0 ];then
                #  echo "            </tr>" >>duibi.html
                #fi
                svn log -r$or:$nr $sourcepath|grep '^r'|grep -E 'lines$|line$'|awk -F'|' -v sul=$sourcepath '{print "  <tr><td class=tablerow>"$1"</td><td class=tablerow>"$3"</td><td class=tablerow>"$2"</td><td class=tablerow>"}{v= $1;system("svn log " sul " -" v "|grep -v \"\\\-\\\-\\\-\\\-\"|sed 1,2d")}{print "</td></tr>"}'>>duibi.html
                #================
				#==================================
		
		echo '              ^              '
		echo '              |              '
		echo '              v              '
		        #==================================
				#================
                echo "		  </tbody>" >>duibi.html
                echo "	    </table>" >>duibi.html
                echo "	  </div>" >>duibi.html
                echo "	  <div>" >>duibi.html
                echo "	    <p>svnurl:http://10.1.198.30/svn/UAPPROGRAM/products/aisiac01/release/${reno}/${i}</p>" >>duibi.html
                echo "	    <table border=0 cellpadding=0 cellspacing=0 width=951 style='border-collapse: collapse;table-layout:fixed;width:715pt'>" >>duibi.html
                echo "		  <colgroup>" >>duibi.html
                echo "            <col width="8%" />" >>duibi.html
                echo "            <col width="38%" />" >>duibi.html
                echo "			<col width="12%" />" >>duibi.html
                echo "			<col width="42%" />" >>duibi.html
                echo "          </colgroup>" >>duibi.html
                echo "		  <tbody>" >>duibi.html
                echo "	      <tr>" >>duibi.html
                echo "		    <td class=tablehead>svn版本号</td>" >>duibi.html
                echo "		    <td class=tablehead>提交时间</td>" >>duibi.html
                echo "		    <td class=tablehead>提交人</td>" >>duibi.html
                echo "		    <td class=tablehead>提交说明</td>" >>duibi.html
                echo "	  	  </tr>" >>duibi.html
                #================
				#==================================
		echo '  '$aiiappath/release/$reno/$i
		svn log -r$or:$nr $aiiappath/release/$reno/$i|awk '{print "     "$0}'
		        #==================================
				#================
                #svn log -r$or:$nr $aiiappath/release/$reno/$i|grep -v '\-\-\-\-\-\-\-\-\-\-\-\-'|grep -v '^$'|awk -F'|' '{if(NF==4){if(NR!=1){print "</tr>"}print "  <tr><td class=tablerow>"$1"</td><td class=tablerow>"$3"</td><td class=tablerow>"$2"</td>"}else{print "<td class=tablerow>"$0"</td>"}}' >>duibi.html
                #if [ `tail -n 1 duibi.html |grep '</tr>'|wc -l` -eq 0 ];then
                #  echo "            </tr>" >>duibi.html
                #fi
                svn log -r$or:$nr $aiiappath/release/$reno/$i|grep '^r'|grep -E 'lines$|line$'|awk -F'|' -v sul=$aiiappath/release/$reno/$i '{print "  <tr><td class=tablerow>"$1"</td><td class=tablerow>"$3"</td><td class=tablerow>"$2"</td><td class=tablerow>"}{v= $1;system("svn log " sul " -" v "|grep -v \"\\\-\\\-\\\-\\\-\"|sed 1,2d")}{print "</td></tr>"}'>>duibi.html
                #================
				#==================================
	else
		echo '  '主干版本$i没有过提交记录
		        #=================================
				#================
                echo "    <table border=0 cellpadding=0 cellspacing=0 width=1175 style='border-collapse:collapse;table-layout:fixed;width:882pt'>" >>duibi.html
                echo "      <col width=69 style='mso-width-source:userset;mso-width-alt:2208;width:52pt'>" >>duibi.html
                echo "      <col width=309 style='mso-width-source:userset;mso-width-alt:9888;width:232pt'>" >>duibi.html
                echo "      <col width=437 style='mso-width-source:userset;mso-width-alt:13984;width:328pt'>" >>duibi.html
                echo "      <col width=72 span=5 style='width:54pt'>" >>duibi.html
                echo "      <tr height=18 style='height:13.5pt'>" >>duibi.html
                echo "       <td class=tdclass height=18 align=left width=69 style='height:13.5pt;width:52pt'>${biaoti}、</td>" >>duibi.html
                echo "       <td class=tdclass width=309 style='width:232pt'><a href=\"javascript:openShutManager('${iproject}detail');\">${iproject}</a></td>" >>duibi.html
                echo "       <td class=tdclass colspan=6 width=797 style='mso-ignore:colspan;width:598pt'><span class= 'detailisnotupdate'>主干版本$i没有过提交记录</span></td>" >>duibi.html
                echo "      </tr>" >>duibi.html
                echo "    </table>" >>duibi.html
                #echo "  <p>${biaoti}、<a href=\"javascript:openShutManager('${iproject}detail');\">${iproject}</a><span class= 'detailisnotupdate'>主干版本$i没有过提交记录</span></p>" >>duibi.html
                echo "  <div id=${iproject}detail ondblclick=\"javascript:openShutManager('${iproject}detail');\" style=\"display: none;\">" >>duibi.html
                echo "    <div>" >>duibi.html
                echo "      <p>svnurl:http://10.1.198.30/svn/UAPPROGRAM/products/aisiac01/program/$i</p>" >>duibi.html
                echo "      <table border=0 cellpadding=0 cellspacing=0 width=951 style='border-collapse: collapse;table-layout:fixed;width:715pt'>" >>duibi.html
                echo "		  <colgroup>" >>duibi.html
                echo "            <col width="8%" />" >>duibi.html
                echo "            <col width="38%" />" >>duibi.html
                echo "			<col width="12%" />" >>duibi.html
                echo "			<col width="42%" />" >>duibi.html
                echo "          </colgroup>" >>duibi.html
                echo "		  <tbody>" >>duibi.html
                echo "        <tr>" >>duibi.html
                echo "              <td class=tablehead>svn版本号</td>" >>duibi.html
                echo "              <td class=tablehead>提交时间</td>" >>duibi.html
                echo "              <td class=tablehead>提交人</td>" >>duibi.html
                echo "              <td class=tablehead>提交说明</td>" >>duibi.html
                echo "            </tr>" >>duibi.html
                #================
				#=================================
		echo '  '$sourcepath
		svn log -r$or:$nr $sourcepath|awk '{print "     "$0}'
		        #=================================
				#================
                #svn log -r$or:$nr $sourcepath|grep -v '\-\-\-\-\-\-\-\-\-\-\-\-'|grep -v '^$'|awk -F'|' '{if(NF==4){if(NR!=1){print "</tr>"}print "  <tr><td class=tablerow>"$1"</td><td class=tablerow>"$3"</td><td class=tablerow>"$2"</td>"}else{print "<td class=tablerow>"$0"</td>"}}' >>duibi.html
                #if [ `tail -n 1 duibi.html |grep '</tr>'|wc -l` -eq 0 ];then
                #  echo "            </tr>" >>duibi.html
                #fi
                svn log -r$or:$nr $sourcepath|grep '^r'|grep -E 'lines$|line$'|awk -F'|' -v sul=$sourcepath '{print "  <tr><td class=tablerow>"$1"</td><td class=tablerow>"$3"</td><td class=tablerow>"$2"</td><td class=tablerow>"}{v= $1;system("svn log " sul " -" v "|grep -v \"\\\-\\\-\\\-\\\-\"|sed 1,2d")}{print "</td></tr>"}'>>duibi.html
                #================
				#=================================
                echo '              ^              '
                echo '              |              '
                echo '              v              '
				#==================================
				#================
                echo "		  </tbody>" >>duibi.html
                echo "      </table>" >>duibi.html
                echo "    </div>" >>duibi.html
                echo "    <div>" >>duibi.html
                echo "      <p>svnurl:http://10.1.198.30/svn/UAPPROGRAM/products/aisiac01/release/${reno}/${i}</p>" >>duibi.html
                echo "      <table border=0 cellpadding=0 cellspacing=0 width=951 style='border-collapse: collapse;table-layout:fixed;width:715pt'>" >>duibi.html
                echo "		  <colgroup>" >>duibi.html
                echo "            <col width="8%" />" >>duibi.html
                echo "            <col width="38%" />" >>duibi.html
                echo "			<col width="12%" />" >>duibi.html
                echo "			<col width="42%" />" >>duibi.html
                echo "          </colgroup>" >>duibi.html
                echo "		  <tbody>" >>duibi.html
                echo "        <tr>" >>duibi.html
                echo "              <td class=tablehead>svn版本号</td>" >>duibi.html
                echo "              <td class=tablehead>提交时间</td>" >>duibi.html
                echo "              <td class=tablehead>提交人</td>" >>duibi.html
                echo "              <td class=tablehead>提交说明</td>" >>duibi.html
                echo "            </tr>" >>duibi.html
                #================
				#==================================
		echo '  '$aiiappath/release/$reno/$i
		svn log -r$or:$nr $aiiappath/release/$reno/$i|awk '{print "     "$0}'
		        #==================================
				#================
                #svn log -r$or:$nr $aiiappath/release/$reno/$i|grep -v '\-\-\-\-\-\-\-\-\-\-\-\-'|grep -v '^$'|awk -F'|' '{if(NF==4){if(NR!=1){print "</tr>"}print "  <tr><td class=tablerow>"$1"</td><td class=tablerow>"$3"</td><td class=tablerow>"$2"</td>"}else{print "<td class=tablerow>"$0"</td>"}}' >>duibi.html
                #if [ `tail -n 1 duibi.html |grep '</tr>'|wc -l` -eq 0 ];then
                #  echo "            </tr>" >>duibi.html
                #fi
                svn log -r$or:$nr $aiiappath/release/$reno/$i|grep '^r'|grep -E 'lines$|line$'|awk -F'|' -v sul=$aiiappath/release/$reno/$i '{print "  <tr><td class=tablerow>"$1"</td><td class=tablerow>"$3"</td><td class=tablerow>"$2"</td><td class=tablerow>"}{v= $1;system("svn log " sul " -" v "|grep -v \"\\\-\\\-\\\-\\\-\"|sed 1,2d")}{print "</td></tr>"}'>>duibi.html
                #================
				#==================================
	fi
	    #==================================
		#================
		echo "		  </tbody>" >>duibi.html
        echo "	    </table>" >>duibi.html
        echo "	  </div>" >>duibi.html
        echo "    <a class=textfont href=\"javascript:openShutManager('${iproject}detail');\">收起</a>" >>duibi.html
        echo "	</div>" >>duibi.html
		#================
		#==================================

 
echo '##########################################################################'
biaoti=$[ biaoti + 1 ]
done

#==================================
#===============
echo "  </body>" >>duibi.html
echo "" >>duibi.html
echo "<style>" >>duibi.html
echo ".index{" >>duibi.html
echo "  line-height:5px;" >>duibi.html
echo "  margin-left:40px" >>duibi.html
echo "  }" >>duibi.html
echo ".detailisupdate{" >>duibi.html
echo "  margin-left:40px;" >>duibi.html
echo "  background-color:#FF8C00" >>duibi.html
echo "  }" >>duibi.html
echo ".detailisnotupdate{" >>duibi.html
echo "  margin-left:40px;" >>duibi.html
echo "  background-color:#00FF00" >>duibi.html
echo "  }" >>duibi.html
echo ".tablehead" >>duibi.html
echo "	{mso-style-parent:style0;" >>duibi.html
echo "	text-align:left;" >>duibi.html
echo "	border:.5pt solid windowtext;" >>duibi.html
echo "	background:#BFBFBF;" >>duibi.html
echo "	mso-pattern:black none;}" >>duibi.html
echo ".tablerow" >>duibi.html
echo "	{mso-style-parent:style0;" >>duibi.html
echo "	text-align:left;" >>duibi.html
echo "	border:.5pt solid windowtext;" >>duibi.html
echo "	background:yellow;" >>duibi.html
echo "	mso-pattern:black none;}" >>duibi.html
echo ".tdclass" >>duibi.html
echo "	{mso-style-parent:style0;" >>duibi.html
echo "	padding-top:1px;" >>duibi.html
echo "	padding-right:1px;" >>duibi.html
echo "	padding-left:1px;" >>duibi.html
echo "	mso-ignore:padding;" >>duibi.html
echo "	color:black;" >>duibi.html
echo "	font-size:11.0pt;" >>duibi.html
echo "	font-weight:400;" >>duibi.html
echo "	font-style:normal;" >>duibi.html
echo "	text-decoration:none;" >>duibi.html
echo "	font-family:宋体;" >>duibi.html
echo "	mso-generic-font-family:auto;" >>duibi.html
echo "	mso-font-charset:134;" >>duibi.html
echo "	mso-number-format:General;" >>duibi.html
echo "	text-align:general;" >>duibi.html
echo "	vertical-align:middle;" >>duibi.html
echo "	border:none;" >>duibi.html
echo "	mso-background-source:auto;" >>duibi.html
echo "	mso-pattern:auto;" >>duibi.html
echo "	mso-protection:locked visible;" >>duibi.html
echo "	white-space:nowrap;" >>duibi.html
echo "	mso-rotate:0;}" >>duibi.html
echo "td" >>duibi.html
echo "	{mso-style-parent:style0;" >>duibi.html
echo "	padding-top:1px;" >>duibi.html
echo "	padding-right:1px;" >>duibi.html
echo "	padding-left:1px;" >>duibi.html
echo "	mso-ignore:padding;" >>duibi.html
echo "	color:black;" >>duibi.html
echo "	font-size:11.0pt;" >>duibi.html
echo "	font-weight:400;" >>duibi.html
echo "	font-style:normal;" >>duibi.html
echo "	text-decoration:none;" >>duibi.html
echo "	font-family:宋体;" >>duibi.html
echo "	mso-generic-font-family:auto;" >>duibi.html
echo "	mso-font-charset:134;" >>duibi.html
echo "	mso-number-format:General;" >>duibi.html
echo "	text-align:general;" >>duibi.html
echo "	vertical-align:middle;" >>duibi.html
echo "	border:none;" >>duibi.html
echo "	mso-background-source:auto;" >>duibi.html
echo "	mso-pattern:auto;" >>duibi.html
echo "	mso-protection:locked visible;" >>duibi.html
echo "	mso-rotate:0;}" >>duibi.html
echo "p{" >>duibi.html
echo "	font-size:11.0pt;" >>duibi.html
echo "	font-weight:400;" >>duibi.html
echo "	font-style:normal;" >>duibi.html
echo "	text-decoration:none;" >>duibi.html
echo "	font-family:宋体;" >>duibi.html
echo "    }" >>duibi.html
echo ".textfont{" >>duibi.html
echo "	font-size:11.0pt;" >>duibi.html
echo "	font-weight:400;" >>duibi.html
echo "	font-style:normal;" >>duibi.html
echo "	text-decoration:none;" >>duibi.html
echo "	font-family:宋体;" >>duibi.html
echo "    }" >>duibi.html
echo "</style>" >>duibi.html
echo "<script>" >>duibi.html
echo "function openShutManager(id){" >>duibi.html
echo "  var obj=document.getElementById(id)" >>duibi.html
echo "  if (obj.style.display=='none'){" >>duibi.html
echo "    obj.style.display='block'" >>duibi.html
echo "  }else{" >>duibi.html
echo "    obj.style.display='none'" >>duibi.html
echo "  }" >>duibi.html
echo "}" >>duibi.html
echo "</script>" >>duibi.html
echo "</html>" >>duibi.html
#===============
#==================================
iconv -f gbk -t utf-8 duibi.html > "report.html"
