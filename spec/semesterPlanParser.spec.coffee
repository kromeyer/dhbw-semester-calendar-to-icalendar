
###
  @author   Patrick Kromeyer
###

semesterPlanParser = require '../src/semesterPlanParser.js'

describe 'semesterPlanParser', ->

  html = '
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html lang="de" xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>DHBW - Kurskalender</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="cjs/dhwb.css" />
	<link rel="stylesheet" href="cjs/jquery.mobile.structure-1.0rc2.min.css" />
	<script src="cjs/jquery-1.6.4.min.js"></script>
	<script src="cjs/jquery.mobile-1.0rc2.min.js"></script>
	<script>
	function printUrl(url) {
	    $(\'#printFrame\').attr(\'src\', url);
	}
	</script>
	<style>
		.ui-li-static.ui-li {
			/*padding:0.5em 5px;
			font-size:13px;*/
		}

	</style>
</head>
<body>
<div data-role="page" data-theme="a">
			<div data-role="header" data-theme="a">
					<div style="text-align:center;">
					<div class="header-txt-c">
						<h1><span>WMMK10 .<span></h1>
						<a href="index.php?action=view&gid=3084001&uid=4592001&date=1362351599"  data-theme="b" data-role="button" data-inline="true" data-icon="arrow-l"  data-iconpos="left">&nbsp;</a>
						<span class="ui-btn-inline"><span class="header-txt-r">KW 10</span></span>
						<a href="index.php?action=view&gid=3084001&uid=4592001&date=1362956400"  data-theme="b" data-role="button" data-inline="true" data-icon="arrow-r"  data-iconpos="right">&nbsp;</a>
					</div>
					<a class="logo" href="index.php"><img src="cjs/images/logo.png" /></a>
					<a href="javascript:void(printUrl(\'print.php?uid=4592001&date=1362351600\'))" data-icon=""  data-theme="b" data-role="button" data-inline="true" style="position:absolute;right:15px;bottom:16px;width:90px;">Drucken</a><a href="index.php" data-icon="home"  data-theme="b" data-role="button" data-inline="true" data-iconpos="notext" style="position:absolute;right:15px;top:10px;"></a><a href="index.php?action=list&amp;gid=3084001" data-icon="back"  data-theme="b" data-role="button" data-inline="true" data-iconpos="notext" style="position:absolute;right:50px;top:10px;"></a>
				</div>
			</div>
<div data-role="content"" style="text-align:center;padding:0 5px;"><div class="ui-grid-e"><div class="ui-block-a"><div style="margin:0 5px 0 5px"><ul data-role="listview" data-inset="true" data-theme="b"><li data-role="list-divider">Montag, 04.03</li></ul></div></div><div class="ui-block-b"><div style="margin:0 5px 0 5px"><ul data-role="listview" data-inset="true" data-theme="b"><li data-role="list-divider">Dienstag, 05.03</li></ul></div></div><div class="ui-block-c"><div style="margin:0 5px 0 5px"><ul data-role="listview" data-inset="true" data-theme="b"><li data-role="list-divider">Mittwoch, 06.03</li></ul></div></div><div class="ui-block-d"><div style="margin:0 5px 0 5px"><ul data-role="listview" data-inset="true" data-theme="b"><li data-role="list-divider">Donnerstag, 07.03</li><li class=""><div class="cal-time">09:15-12:15</div><div class="cal-title">Angewandte Medienkonzepte</div><div class="cal-res">Raum 135B</div></li></ul></div></div><div class="ui-block-e"><div style="margin:0 5px 0 5px"><ul data-role="listview" data-inset="true" data-theme="b"><li data-role="list-divider">Freitag, 08.03</li></ul></div></div><div class="ui-block-f"><div style="margin:0 5px 0 5px"><ul data-role="listview" data-inset="true" data-theme="b"><li data-role="list-divider">Samstag, 09.03</li></ul></div></div></div></div><iframe width="1" height="1" id="printFrame" frameborder="0" />
</div>
</body>
</html>
'

  it 'should return a list of event objects', ->
    result = semesterPlanParser(html)
    expect(Object.prototype.toString.call(result)).toBe('[object Array]')

  it 'should return a correct event', ->
    result = semesterPlanParser(html).shift()

    expect(result.name).toBe('Angewandte Medienkonzepte')
    expect(result.dateStart.toJSON()).toBe(new Date(2013, 3-1, 7, 9, 15, 0, 0).toJSON())
    expect(result.dateEnd.toJSON()).toBe(new Date(2013, 3-1, 7, 12, 15, 0, 0).toJSON())
    expect(result.description).toBe('Raum 135B')
