#!/usr/bin/perl

use strict;
use warnings;
use CGI;

print CGI->header('application/json');

print << "FINI";
{
	"disasters": [
		{
			"disaster": {
				"disaster_id": 1,
				"area_abbreviation": "LAC",
				"area_name": "Latin America & Caribbean",
				"lending_type": "IDA",
				"location_lat": "40.7483282",
				"location_lon": "-73.9962255",
				"name": "Haiti",
				"population_affected": 100000,
				"severity": "high",
				"type": "hurricane",
				"date_start": "2010-12-01",
				"funded": "yes",
				"projects": [
					{
						"project_id": 1,
						"name": "Some project name",
						"type": "Rebuilding Building",
						"description": "This is a rather long description.",
						"date_start": "2010-01-01",
						"date_end": null,
						"funded": "yes",
						"lending_type": "IDA",
						"organizations": [
							{
								"organization_id": 1,
								"name": "Red Cross",
								"type": "NGO",
								"note": "",
								"size": "Large",
								"description": "Something rather nice",
								"qr_url": "http://www.the2dcode.com/qr-code/120994",
								"url": "http://www.redcross.org",
								"logo_url": "http://www.redcross.org/files/site/images/logo.gif",
								"feed_url": "http://twitter.com/favorites/13907922.rss",
								"contacts": [
									{
										"contact_type": "twitter",
										"contact_info": "http://twitter.com/juancmuller"
									}
								]
							}
						]
					}
				]
			}
		}
	]
}
FINI
