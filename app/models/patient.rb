class Patient < ApplicationRecord
  has_many :medical_records, dependent: :destroy
  has_many :doctors, through: :medical_records
  has_many :events, dependent: :destroy
  has_many :conditions
  has_one_attached :photo
  has_one_attached :id_card
  belongs_to :user

  # validates :first_name, presence: true
  enum sex: { "non-binary" => 0, female: 1, male: 2 }
  enum insurance: {
    "Japanese public medical insurance" => 0,
    "Private insurance(self paid)" => 1,
    "None" => 2
  }
  enum nationality: {
    Afghanistan: 0,
    AlandIslands: 1,
    Albania: 2,
    Algeria: 3,
    AmericanSamoa: 4,
    Andorra: 5,
    Angola: 6,
    Anguilla: 7,
    Antarctica: 8,
    AntiguaAndBarbuda: 9,
    Argentina: 10,
    Armenia: 11,
    Aruba: 12,
    Australia: 13,
    Austria: 14,
    Azerbaijan: 15,
    Bahamas: 16,
    Bahrain: 17,
    Bangladesh: 18,
    Barbados: 19,
    Belarus: 20,
    Belgium: 21,
    Belize: 22,
    Benin: 23,
    Bermuda: 24,
    Bhutan: 25,
    Bolivia: 26,
    BonaireSintEustatiusSaba: 27,
    BosniaAndHerzegovina: 28,
    Botswana: 29,
    BouvetIsland: 30,
    Brazil: 31,
    BritishIndianOceanTerritory: 32,
    BruneiDarussalam: 33,
    Bulgaria: 34,
    BurkinaFaso: 35,
    Burundi: 36,
    Cambodia: 37,
    Cameroon: 38,
    Canada: 39,
    CapeVerde: 40,
    CaymanIslands: 41,
    CentralAfricanRepublic: 42,
    Chad: 43,
    Chile: 44,
    China: 45,
    ChristmasIsland: 46,
    CocosKeelingIslands: 47,
    Colombia: 48,
    Comoros: 49,
    Congo: 50,
    CongoDemocraticRepublic: 51,
    CookIslands: 52,
    CostaRica: 53,
    CoteDIvoire: 54,
    Croatia: 55,
    Cuba: 56,
    Curaçao: 57,
    Cyprus: 58,
    CzechRepublic: 59,
    Denmark: 60,
    Djibouti: 61,
    Dominica: 62,
    DominicanRepublic: 63,
    Ecuador: 64,
    Egypt: 65,
    ElSalvador: 66,
    EquatorialGuinea: 67,
    Eritrea: 68,
    Estonia: 69,
    Ethiopia: 70,
    FalklandIslands: 71,
    FaroeIslands: 72,
    Fiji: 73,
    Finland: 74,
    France: 75,
    FrenchGuiana: 76,
    FrenchPolynesia: 77,
    FrenchSouthernTerritories: 78,
    Gabon: 79,
    Gambia: 80,
    Georgia: 81,
    Germany: 82,
    Ghana: 83,
    Gibraltar: 84,
    Greece: 85,
    Greenland: 86,
    Grenada: 87,
    Guadeloupe: 88,
    Guam: 89,
    Guatemala: 90,
    Guernsey: 91,
    Guinea: 92,
    GuineaBissau: 93,
    Guyana: 94,
    Haiti: 95,
    HeardIslandMcdonaldIslands: 96,
    HolySeeVaticanCityState: 97,
    Honduras: 98,
    HongKong: 99,
    Hungary: 100,
    Iceland: 101,
    India: 102,
    Indonesia: 103,
    Iran: 104,
    Iraq: 105,
    Ireland: 106,
    IsleOfMan: 107,
    Israel: 108,
    Italy: 109,
    Jamaica: 110,
    Japan: 111,
    Jersey: 112,
    Jordan: 113,
    Kazakhstan: 114,
    Kenya: 115,
    Kiribati: 116,
    Korea: 117,
    KoreaDemocraticPeoplesRepublic: 118,
    Kuwait: 119,
    Kyrgyzstan: 120,
    LaoPeoplesDemocraticRepublic: 121,
    Latvia: 122,
    Lebanon: 123,
    Lesotho: 124,
    Liberia: 125,
    LibyanArabJamahiriya: 126,
    Liechtenstein: 127,
    Lithuania: 128,
    Luxembourg: 129,
    Macao: 130,
    Macedonia: 131,
    Madagascar: 132,
    Malawi: 133,
    Malaysia: 134,
    Maldives: 135,
    Mali: 136,
    Malta: 137,
    MarshallIslands: 138,
    Martinique: 139,
    Mauritania: 140,
    Mauritius: 141,
    Mayotte: 142,
    Mexico: 143,
    Micronesia: 144,
    Moldova: 145,
    Monaco: 146,
    Mongolia: 147,
    Montenegro: 148,
    Montserrat: 149,
    Morocco: 150,
    Mozambique: 151,
    Myanmar: 152,
    Namibia: 153,
    Nauru: 154,
    Nepal: 155,
    Netherlands: 156,
    NewCaledonia: 157,
    NewZealand: 158,
    Nicaragua: 159,
    Niger: 160,
    Nigeria: 161,
    Niue: 162,
    NorfolkIsland: 163,
    NorthernMarianaIslands: 164,
    Norway: 165,
    Oman: 166,
    Pakistan: 167,
    Palau: 168,
    PalestinianTerritory: 169,
    Panama: 170,
    PapuaNewGuinea: 171,
    Paraguay: 172,
    Peru: 173,
    Philippines: 174,
    Pitcairn: 175,
    Poland: 176,
    Portugal: 177,
    PuertoRico: 178,
    Qatar: 179,
    Reunion: 180,
    Romania: 181,
    RussianFederation: 182,
    Rwanda: 183,
    SaintBarthelemy: 184,
    SaintHelena: 185,
    SaintKittsAndNevis: 186,
    SaintLucia: 187,
    SaintMartin: 188,
    SaintPierreAndMiquelon: 189,
    SaintVincentAndGrenadines: 190,
    Samoa: 191,
    SanMarino: 192,
    SaoTomeAndPrincipe: 193,
    SaudiArabia: 194,
    Senegal: 195,
    Serbia: 196,
    Seychelles: 197,
    SierraLeone: 198,
    Singapore: 199,
    SintMaarten: 200,
    Slovakia: 201,
    Slovenia: 202,
    SolomonIslands: 203,
    Somalia: 204,
    SouthAfrica: 205,
    SouthGeorgiaAndSandwichIsl: 206,
    SouthSudan: 207,
    Spain: 208,
    SriLanka: 209,
    Sudan: 210,
    Suriname: 211,
    SvalbardAndJanMayen: 212,
    Swaziland: 213,
    Sweden: 214,
    Switzerland: 215,
    SyrianArabRepublic: 216,
    Taiwan: 217,
    Tajikistan: 218,
    Tanzania: 219,
    Thailand: 220,
    TimorLeste: 221,
    Togo: 222,
    Tokelau: 223,
    Tonga: 224,
    TrinidadAndTobago: 225,
    Tunisia: 226,
    Turkey: 227,
    Turkmenistan: 228,
    TurksAndCaicosIslands: 229,
    Tuvalu: 230,
    Uganda: 231,
    Ukraine: 232,
    UnitedArabEmirates: 233,
    UnitedKingdom: 234,
    UnitedStates: 235,
    UnitedStatesOutlyingIslands: 236,
    Uruguay: 237,
    Uzbekistan: 238,
    Vanuatu: 239,
    Venezuela: 240,
    Vietnam: 241,
    VirginIslandsBritish: 242,
    VirginIslandsUS: 243,
    WallisAndFutuna: 244,
    WesternSahara: 245,
    Yemen: 246,
    Zambia: 247,
    Zimbabwe: 248
  }

  def qr_code(url)
    @qr_code = RQRCode::QRCode.new(url)
    @svg = @qr_code.as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      standalone: true,
      use_path: true,
      module_size: 5
    )
    return @svg
  end
end
