var load_json = function ()
{
	return {
		'disaster': {
			'disaster_id': 1,
			'location_lat': '41',
			'location_lon': '-72',
			'name': 'Haiti',
			'area_name': 'Latin America & Caribbean',
			'area_abbreviation': 'LAC',
			'type': 'hurricane',
			'population_affected': 100000,
			'severity': 'high',
			'lending_type': 'IDA',
			'projects': [
				{
					'project_id': 1,
					'name': 'Some project name',
					'type': 'Rebuilding Building',
					'description': 'This is a rather long description.',
					'date_start': '2010-01-01',
					'date_end': null,
					'funded': 'yes',
					'lending_type': 'IDA',
					'organizations': [
						{
							'organization_id': 1,
							'name': 'Red Cross',
							'type': 'NGO',
							'note': '',
							'size': 'Large',
							'description': 'Something rather nice',
							'qr_url': 'http://www.the2dcode.com/qr-code/120994',
							'url': 'http://www.redcross.org',
							'feed_url': 'http://twitter.com/favorites/13907922.rss',
							'contacts': [
								{
									'contact_type': 'twitter',
									'contact_info': 'http://twitter.com/juancmuller'
								}
							]
						}
					]
				}
			]
		}
	}
};
