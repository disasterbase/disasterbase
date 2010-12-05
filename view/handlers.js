var render_results = function (data, textStatus, req) {
	var disasters = data.disasters;

	var head_info = $("#head_info");
	var head_map  = $("#head_map");
	var main      = $("#main");
	var footer    = $("#footer");

	var template  = _.template($("#header_template").html());

	$.each(disasters, function () {
		var today = new Date();
		var start = new Date(this.disaster.date_start);
		this.disaster.days = parseInt((today - start) / 1000 / 60 / 60 / 24);
		head_info.append(template(this));

		var projects = this.disaster.projects;
		$.each(projects, function () {
			var organizations = this.organizations;
			$.each(organizations, function () {
				var template = _.template($("#organization_logo").html());
				main.append(template(this));
			});
		});

		new google.maps.Map($("#map-container"), {
			center: new google.maps.LatLng(
				this.disaster.location_lat,
				this.disaster.location_lon
			),
			zoom: 12,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		});
	});
};

