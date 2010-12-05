var render_results = function (data, textStatus, req) {
	var disasters = data.disasters;

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

		var projects = this.disaster.projects;
		$.each(projects, function () {
			var organizations = this.organizations;
			template = _.template($("#organization_logo").html());
			$.each(organizations, function () {
				for (var i = 0; i < 10; i++)
					col1.append(template(this));
			});
		});

		var images = this.disaster.images;
		template = _.template($("#image").html());
		$.each(images, function () {
			col2.append(template(this));
		});

		new google.maps.Map(document.getElementById("map_container"), {
			center: new google.maps.LatLng(
				this.disaster.location_lat,
				this.disaster.location_lon
			),
			zoom: 7,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		});
	});
};
