/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Fields : Codable {
	let complement_adresse : String?
	let geo_shape : Geo_shape?
	let horaire : String?
	let acces_pmr : String?
	let arrondissement : Int?
	let geo_point_2d : [Double]?
	let source : String?
	let gestionnaire : String?
	let adresse : String?
	let type : String?

	enum CodingKeys: String, CodingKey {

		case complement_adresse = "complement_adresse"
		case geo_shape = "geo_shape"
		case horaire = "horaire"
		case acces_pmr = "acces_pmr"
		case arrondissement = "arrondissement"
		case geo_point_2d = "geo_point_2d"
		case source = "source"
		case gestionnaire = "gestionnaire"
		case adresse = "adresse"
		case type = "type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		complement_adresse = try values.decodeIfPresent(String.self, forKey: .complement_adresse)
		geo_shape = try values.decodeIfPresent(Geo_shape.self, forKey: .geo_shape)
		horaire = try values.decodeIfPresent(String.self, forKey: .horaire)
		acces_pmr = try values.decodeIfPresent(String.self, forKey: .acces_pmr)
		arrondissement = try values.decodeIfPresent(Int.self, forKey: .arrondissement)
		geo_point_2d = try values.decodeIfPresent([Double].self, forKey: .geo_point_2d)
		source = try values.decodeIfPresent(String.self, forKey: .source)
		gestionnaire = try values.decodeIfPresent(String.self, forKey: .gestionnaire)
		adresse = try values.decodeIfPresent(String.self, forKey: .adresse)
		type = try values.decodeIfPresent(String.self, forKey: .type)
	}

}