var disasters;
var timeout = 10; //seconds

var clean_head = function ()
{
	$("div#head_info").html("");
	$("div#head_map").html("");
	$("div#head_map").css({'background': 'white'});
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

var render_results = function (data, textStatus, req) {
	disasters = data.disasters;

	var head_info = $("#head_info");
	var head_map  = $("#head_map");
	var col1      = $("#col1");
	var col2      = $("#col2");
	var footer    = $("#footer");

	var template  = _.template($("#header_template").html());

	$.each(disasters, function () {
		var today = new Date();
		var start = new Date(this.disaster.date_start);
		this.disaster.days = parseInt((today - start) / 1000 / 60 / 60 / 24);
		head_info.append(template(this));

		$.each(this.disaster.projects, function () {
			var organizations = this.organizations;
			template = _.template($("#organization_logo").html());
			$.each(organizations, function () {
				for (var i = 0; i < 10; i++)
					col1.append(template(this));
			});

			_.delay(show_organizations, 1000 * timeout, organizations);
		});

		template = _.template($("#image").html());
		$.each(this.disaster.images, function () {
			col2.append(template(this));
		});

		new google.maps.Map(document.getElementById("head_map"), {
			center: new google.maps.LatLng(
				this.disaster.location_lat,
				this.disaster.location_lon
			),
			zoom: 7,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		});
	});
};

var show_organizations = function (organizations)
{
	clean_main();
	clean_footer();
	var len = organizations.length
	render_pager(len);
	var i = 0;
	while (i < len)
	{
		_.delay(show_organization, 1000 * timeout, organizations[i]);
		i++;
	}
};

var show_organization = function (organization, i)
{
	clean_main();
	$(".page").css({ 'color': 'black'});
	$("#page_" + i).css({ 'color': 'red'});
	var template = _.template($("#organization_details").html());
	$("div#col1").append(template(organization));
	$("div#col1").append('<script type="text/javascript" src="' + organization.feed_url + '"></script>');

	$("#col2").empty();
	template = _.template($("#feed_entry").html());
}

var display_tweets = function (tweets)
{
	var template = _.template($("#feed_entry").html());
	$.each(tweets, function () {
		$('#col2').append(template(this));
	});
}

var render_pager = function (count)
{
	var template = _.template($("#page").html());
	for (var i = 0; i < count; i++)
		$("div#footer").append(template({ "counter": i }));
};

// Entry point
$(document).ready(function () {
	$.ajax({
		url: 'fake_data.json',
		cache: false,
		dataType: 'json',
		data: {},
		success: render_results
	});
});
