var disasters;
var timeout = 10; //seconds
var map;

var clean_head = function ()
{
	$("div#head_info").html("");
	//$("div#head_map").html("");
	//$("div#head_map").css({'background': 'white'});
};

var clean_main = function ()
{
	$("div#col1").html("");
	$("div#col2").html("");
};

var clean_footer = function ()
{
	$("div#footer").html("");
};

var clean_all = function ()
{
	clean_head();
	clean_main();
	clean_footer();
};

var successful_request = function (data, textStatus, req)
{
	disasters = data.disasters;
	render_results(disasters);
}

var render_results = function (dis)
{
	var head_info = $("#head_info");
	var head_map  = $("#head_map");
	var col1      = $("#col1");
	var col2      = $("#col2");
	var footer    = $("#footer");

	clean_all();

	var template  = _.template($("#header_template").html());

	$.each(dis.disasters, function () {
		var today = new Date();
		var start = new Date(this.disaster.date_start);
		this.disaster.days = parseInt((today - start) / 1000 / 60 / 60 / 24);
		head_info.append(template(this));

		$.each(this.disaster.projects, function () {
			var organizations = this.organizations;
			template = _.template($("#organization_logo").html());
			$.each(organizations, function () {
				col1.append(template(this));
			});

			_.delay(show_organizations, 1000 * timeout, organizations);
		});

		template = _.template($("#image").html());
		$.each(this.disaster.media, function () {
			col2.append(template(this));
		});

		var center = new google.maps.LatLng(this.disaster.location_lat, this.disaster.location_lon);

		if (map)
		{
			map.panTo(center);
			map.setZoom(7);
		}
		else
		{
			map = new google.maps.Map(document.getElementById("head_map"), {
				center: center,
				zoom: 7,
				mapTypeId: google.maps.MapTypeId.ROADMAP
			});
		}
	});
};

var show_organizations = function (organizations)
{
	clean_main();
	clean_footer();
	var len = organizations.length
	render_pager(len);
	var i = 0;

	show_organization(organizations, i, len);
};

var show_organization = function (organizations, i, all)
{
	clean_main();
	var organization = organizations[i];
	$(".page").css({ 'color': 'black'});
	$("#page_" + i).css({ 'color': 'red'});
	var template = _.template($("#organization_details").html());
	$("div#col1").append(template(organization));
	$("div#col1").append('<script type="text/javascript" src="' + organization.feed_url + '"></script>');

	$("#col2").empty();
	template = _.template($("#feed_entry").html());

	i++;
	if (i == all)
		_.delay(do_magical_things, 1000 * timeout);
	else
		_.delay(show_organization, 1000 * timeout, organizations, i, all);
}

var display_tweets = function (tweets)
{
	var template = _.template($("#feed_entry").html());
	$.each(tweets, function () {
		var today = new Date();
		var then = new Date(this.created_at);

		var days = parseInt((today - then) / 1000 / 60 / 60 / 24);
		if (days == 0)
			days = 'today';
		else if (days == 1)
			days = days + ' day ago';
		else
			days = days + ' days ago';

		this.days = days;

		$('#col2').append(template(this));
	});
}

var render_pager = function (count)
{
	var template = _.template($("#page").html());
	for (var i = 0; i < count; i++)
		$("div#footer").append(template({ "counter": i }));
};

do_magical_things = function ()
{
	$.ajax({
		url: 'get_disasters.mhtml',
		cache: false,
		dataType: 'json',
		data: {},
		success: render_results
	});
}

// Entry point
$(document).ready(do_magical_things);
