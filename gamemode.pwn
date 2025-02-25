/*
/////////////////////////////////////////////////////////////////////////////////////////////////

										INDONATION DEVELOPMENT
									Indonation Alterlife Project
									 SINCE FEBRUARY - 25 - 2025
								SUPPORTED BY: INDONATION COMMUNITY

										#indonationstayhigh                                                                                

//////////////////////////////////////////////////////////////////////////////////////////////////
*/
#define NO_TAGS
#define MIXED_SPELLINGS
#include <open.mp>
#undef MAX_PLAYERS
#define MAX_PLAYERS	200
#include <crashdetect>
#include <YSI_Data/y_iterate>
#include <gvar>
#include <a_mysql>
#include <a_actor>
#include <a_zones>
#include <progress2>
#include <Pawn.CMD>
#include <selection>
#include <eSelection>
#include <mselec.inc>
//#include <mSelection.inc>
#include <FiTimestamp>
#include <Dini>
#include <dini.inc>
#include <core>
#include <float>
#define ENABLE_3D_TRYG_YSI_SUPPORT
#include <3DTryg>
#include <streamer>
#include <EVF2>
#include <YSI_Coding\y_timers>
#include <YSI_Storage\y_ini>
#include <sscanf2>
#include <yom_buttons>
#include <geoiplite>
#include <garageblock>
#include <tp>
#include <compat>
#define DCMD_PREFIX '!'
#define IsValidTimer
#include <discord-connector>
#include <discord-cmd>
#define number_format
#include <loadingbar>
//#include <mSelection>
#include <samp-loadingbar>
#include <sampvoice>
#include <bcrypt>
//#include <client-check>
//#include <notify>
//#include <nex-ac>
#include <textdraw-streamer>
//#include <localstreamer>
#define PlayerInfo PlayerData
#define PlayerData pData
#define LENZPBLC::%0(%1) forward %0(%1); public %0(%1)
new Text3D:TagKeluar[MAX_PLAYERS];
new STATUS_BOT2;
//anticjlenz
new vehicle_driver[MAX_VEHICLES];
new PlayerTent[MAX_PLAYERS];

new Text3D:LenzSangar[MAX_PLAYERS];
//new Text3D:cNametag[MAX_PLAYERS];
new TogglePhone[MAX_PLAYERS];
new ToggleSid[MAX_PLAYERS];
new ToggleCall[MAX_PLAYERS];
new JamCall[MAX_PLAYERS];
new DetikCall[MAX_PLAYERS];
new MenitCall[MAX_PLAYERS];
new CallTimer[MAX_PLAYERS];
new cbugwarn[MAX_PLAYERS];
new DCC_Channel:g_Discord_Serverstatus;
//balapan
enum e_race_data
{
	raceStart,
	Float:racePos1[3],
	Float:racePos2[3],
	Float:racePos3[3],
	Float:racePos4[3],
	Float:racePos5[3],
	Float:raceFinish[3],
};
new RaceData[MAX_PLAYERS][e_race_data];

//MoneyBags
enum mbInfo
{
	mCreated,
    Float:mbX,
    Float:mbY,
    Float:mbZ,
    mPickup,
    mAmount,
    mMoneybag
};
#define MAX_MONEYBAGS            	(150)
new MoneyInfo[MAX_MONEYBAGS][mbInfo];
new warped[MAX_PLAYERS];

//antidbdesertboskuah
static warnings[MAX_PLAYERS char] = {0,...};

//-----[ Modular ]-----
#include "DEFINE.inc"
#define GRP::%0(%1) forward %0(%1); public %0(%1)

//-----[ Quiz ]-----
new quiz,
	answers[256],
	answermade,
	qprs;

//greenzone map
//new gzmap[25];

//bunnyhop
new Jump[MAX_PLAYERS];
//pemadamsamd
new g_aFireObjects[36] = {INVALID_OBJECT_ID, ...};
new g_aFireExtinguished[36];
//new pemadaman[MAX_PLAYERS];
//nikahan
new WatchingTV[MAX_PLAYERS];
new Spectating[MAX_PLAYERS];
//STATIC SAPD
// new SAPDVeh[MAX_PLAYERS];
//STATIC SANA
new SANAVeh[MAX_PLAYERS];
//STATIC SAGS
new SAGSVeh[MAX_PLAYERS];
new GOCARVehicles[MAX_PLAYERS];

//callsign
new vehiclecallsign[MAX_VEHICLES];
new STREAMER_TAG_3D_TEXT_LABEL:vehicle3Dtext[MAX_VEHICLES];
//HAULING TRAILER
new TrailerHauling[MAX_PLAYERS];
//-----[ Twitter ]-----
new tweet[60];
//yanto
new Yanto[MAX_PLAYERS];
//bugilcopotbaju
new BajuLaki[MAX_PLAYERS];
new BajuPerempuan[MAX_PLAYERS];
//senjatainventory
new PakaiSenjata[MAX_PLAYERS];
new WaktuMolotov[MAX_PLAYERS];
//drone
new Drones[MAX_PLAYERS];
//mask
//new STREAMER_TAG_3D_TEXT_LABEL:MaskLabel[MAX_PLAYERS];
//ShotTD
//new PlayerText:ShotsTD[MAX_PLAYERS][8];
//discord
new DCC_Channel:activecs;
new DCC_Channel:g_discord_server;
//new DCC_Channel:g_discord_houselogs;
new DCC_Channel:g_Discord_ReportLogs;
new DCC_Channel:g_Discord_ReportAccept;
new DCC_Channel:g_cekpin;
new DCC_Channel:g_Discord_Information;
new DCC_Guild:merpatiGuild;
new DCC_Channel:panelMerpati;
//new DCC_Channel:g_discord_logs;
//-----[ Rob ]-----
new RobMember = 0;
new Gzlenz[5];
//-----[ Event ]-----
new EventCreated = 0, 
	EventStarted = 0, 
	EventPrize = 500;
new Float: RedX, 
	Float: RedY, 
	Float: RedZ, 
	EventInt, 
	EventWorld;
new Float: BlueX, 
	Float: BlueY, 
	Float: BlueZ;
new EventHP = 100,
	EventArmour = 0,
	EventLocked = 0;
new Float: TelevisiX,
	Float: TelevisiY,
	Float: TelevisiZ;
new Float: CrateX,
	Float: CrateY,
	Float: CrateZ;
new EventWeapon1, 
	EventWeapon2, 
	EventWeapon3, 
	EventWeapon4, 
	EventWeapon5;
new BlueTeam = 0, 
	RedTeam = 0;
new MaxRedTeam = 5, 
	MaxBlueTeam = 5;
new IsAtEvent[MAX_PLAYERS];

new shotTime[MAX_PLAYERS];
new shot[MAX_PLAYERS];
new AntiBHOP[MAX_PLAYERS];

//-----[ Discord Connector ]-----
new pemainic;
new upt = 0;
//afk player
new p_tick[MAX_PLAYERS],
    p_afktime[MAX_PLAYERS];
#define CONVERT_TIME_TO_SECONDS 	1
#define CONVERT_TIME_TO_MINUTES 	2
#define CONVERT_TIME_TO_HOURS 		3
#define CONVERT_TIME_TO_DAYS 		4
#define CONVERT_TIME_TO_MONTHS 		5
#define CONVERT_TIME_TO_YEARS 		6


//specnew
/*static const VEHICLE_NAMES[][] = {
	"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster", "Stretch",
	"Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi",
	"Washington", "Bobcat", "Mr Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator",
	"Bus", "Rhino", "Barracks", "Hotknife", "Trailer 1", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero",
	"Packer", "Monster", "Admiral", "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer 2", "Turismo", "Speeder", "Reefer", "Tropic",
	"Flatbed", "Yankee", "Caddy", "Solair", "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider",
	"Glendale", "Oceanic", "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350",
	"Walton", "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
	"FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick", "Boxville", "Benson",
	"Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT", "Elegant", "Journey",
	"Bike", "Mountain Bike", "Beagle", "Cropdust", "Stunt", "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal",
	"Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune", "Cadrona", "FBI Truck", "Willard", "Forklift",
	"Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent", "Bullet", "Clover",
	"Sadler", "Firetruck LA", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite",
	"Windsor", "Monster A", "Monster B", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma",
	"Savanna", "Bandito", "Freight Flat", "Streak Carriage", "Kart", "Mower", "Duneride", "Sweeper", "Broadway", "Tornado", "AT-400",
	"DFT-30", "Huntley", "Stafford", "BF-400", "Newsvan", "Tug", "Trailer 3", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
	"Freight Carriage", "Trailer 3", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car (LSPD)", "Police Car (SFPD)",
	"Police Car (LVPD)", "Police Ranger", "Picador", "S.W.A.T. Tank", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage Trailer A",
	"Luggage Trailer B", "Stair Trailer", "Boxville", "Farm Plow", "Utility Trailer"
};

static const Float:VEHICLE_TOP_SPEEDS[] = {
	157.0, 147.0, 186.0, 110.0, 133.0, 164.0, 110.0, 148.0, 100.0, 158.0, 129.0, 221.0, 168.0, 110.0, 105.0, 192.0, 154.0, 270.0, 115.0, 149.0,
	145.0, 154.0, 140.0, 99.0,  135.0, 270.0, 173.0, 165.0, 157.0, 201.0, 190.0, 130.0, 94.0,  110.0, 167.0, 0.0,   149.0, 158.0, 142.0, 168.0,
	136.0, 145.0, 139.0, 126.0, 110.0, 164.0, 270.0, 270.0, 111.0, 0.0,   0.0,   193.0, 270.0, 60.0,  135.0, 157.0, 106.0, 95.0,  157.0, 136.0,
	270.0, 160.0, 111.0, 142.0, 145.0, 145.0, 147.0, 140.0, 144.0, 270.0, 157.0, 110.0, 190.0, 190.0, 149.0, 173.0, 270.0, 186.0, 117.0, 140.0,
	184.0, 73.0,  156.0, 122.0, 190.0, 99.0,  64.0,  270.0, 270.0, 139.0, 157.0, 149.0, 140.0, 270.0, 214.0, 176.0, 162.0, 270.0, 108.0, 123.0,
	140.0, 145.0, 216.0, 216.0, 173.0, 140.0, 179.0, 166.0, 108.0, 79.0,  101.0, 270.0,	270.0, 270.0, 120.0, 142.0, 157.0, 157.0, 164.0, 270.0,
	270.0, 160.0, 176.0, 151.0, 130.0, 160.0, 158.0, 149.0, 176.0, 149.0, 60.0,  70.0,  110.0, 167.0, 168.0, 158.0, 173.0, 0.0,   0.0,   270.0,
	149.0, 203.0, 164.0, 151.0, 150.0, 147.0, 149.0, 142.0, 270.0, 153.0, 145.0, 157.0, 121.0, 270.0, 144.0, 158.0, 113.0, 113.0, 156.0, 178.0,
	169.0, 154.0, 178.0, 270.0, 145.0, 165.0, 160.0, 173.0, 146.0, 0.0,   0.0,   93.0,  60.0,  110.0, 60.0,  158.0, 158.0, 270.0, 130.0, 158.0,
	153.0, 151.0, 136.0, 85.0,  0.0,   153.0, 142.0, 165.0, 108.0, 162.0, 0.0,   0.0,   270.0, 270.0, 130.0, 190.0, 175.0, 175.0, 175.0, 158.0,
	151.0, 110.0, 169.0, 171.0, 148.0, 152.0, 0.0,   0.0,   0.0,   108.0, 0.0,   0.0
};*/

//new Text:playerInfoFrameTD[6];
//new Text:playerInfoTD[7];
//new Text:vehicleInfoFrameTD[2];
//new Text:vehicleInfoTD[4];

//new PlayerText:playerInfoPTD[MAX_PLAYERS][8];

//new playerSpectateID[MAX_PLAYERS];
//new bool:playerSpectateTypeVehicle[MAX_PLAYERS];

//new Iterator:SpectatePlayers<MAX_PLAYERS>;

//new playerVirtualWorld[MAX_PLAYERS];

//new oldPlayerVirtualWorld[MAX_PLAYERS];
//new oldPlayerInterior[MAX_PLAYERS];
//new Float:oldPlayerPosition[MAX_PLAYERS][4];
//new Float:oldPlayerHealth[MAX_PLAYERS];
//new Float:oldPlayerArmour[MAX_PLAYERS];

//#define BUTTON_PREVIOUS playerInfoFrameTD[1]
//#define BUTTON_NEXT playerInfoFrameTD[2]


//DAMAGESLOGS
enum {
	BODY_PART_TORSO = 3,
	BODY_PART_GROIN,
	BODY_PART_RIGHT_ARM,
	BODY_PART_LEFT_ARM,
	BODY_PART_RIGHT_LEG,
	BODY_PART_LEFT_LEG,
	BODY_PART_HEAD
}


//-----[ Selfie System ]-----
new takingselfie[MAX_PLAYERS];
new Float:Degree[MAX_PLAYERS];
const Float: Radius = 1.4; //do not edit this
const Float: Speed  = 1.25; //do not edit this
const Float: Height = 1.0; // do not edit this
new Float:lX[MAX_PLAYERS];
new Float:lY[MAX_PLAYERS];
new Float:lZ[MAX_PLAYERS];
//ROB
new InRob[MAX_PLAYERS];
new Healing;
new stresstimer[MAX_PLAYERS];
//disnaker
new SmugglerCP;
new Cafe;
//disnaker
new Disnaker;
//======[ LENZ JOB ]========
// new Sopirbus;
new Merchantfiller;
new PekerjaSapi;
new mekanik;
new tukangayam;
new petani;
new tukangtebang;
new penambang;
new product;
new markisaa;
new penambangminyak;
//new markisaCP;
new Trucker;
new bagage;
new Taxi;
enum
{
	DIALOG_VOICE,
	DIALOG_LENZVEHD,
	DIALOG_DOKTERLOKAL,
	DIALOG_RAPSODY,
	DIALOG_SLOTS_BET,
	DIALOG_DISNAKER,
	DIALOG_PEMERINTAH,
	DIALOG_MAKE_CHAR,
	DIALOG_CHARLIST,
	DIALOG_CONFIRMCHAR,
	DIALOG_CHAROPTION,
	DIALOG_VERIFYCODE,
	DIALOG_JUALILEGAL,
	DIALOG_UNUSED,
    DIALOG_LOGIN,
    DIALOG_REGISTER,
    DIALOG_AGE,
	DIALOG_GENDER,
	DIALOG_EMAIL,
	DIALOG_PASSWORD,
	DIALOG_STATS,
	DIALOG_SETTINGS,
	DIALOG_HBEMODE,
	// DIALOG_PISSUE,
	DIALOG_CHANGEAGE,
	DIALOG_GOLDSHOP,
	DIALOG_GOLDNAME,
	DIALOG_SELL_BISNISS,
	DIALOG_SELL_BISNIS,
	DIALOG_MY_BISNIS,
	BISNIS_MENU,
	BISNIS_INFO,
	BISNIS_NAME,
	BISNIS_VAULT,
	BISNIS_WITHDRAW,
	BISNIS_DEPOSIT,
	BISNIS_BUYPROD,
	BISNIS_EDITPROD,
	BISNIS_PRICESET,
	DIALOG_AIRDROP,
	DIALOG_AIRDROP1,
	DIALOG_AIRDROP2,
	DIALOG_AIRDROP3,
	DIALOG_PANELPHONE,
	//DEALER
	DEALER_EDITPROD,
	DEALER_PRICESET,
	//EMSTOGGLE
    DIALOG_EMS,
    DIALOG_EMS1,
    DIALOG_EMS2,
    DIALOG_EMS3,
    DIALOG_EMS4,
    DIALOG_EMS5,
    DIALOG_EMSG,
    DIALOG_EMSC,
	//sapd
    DIALOG_SAPDPANEL,
    DIALOG_SAPD1,
    DIALOG_SAPD2,
    DIALOG_SAPD3,
    DIALOG_SAPD4,
    DIALOG_SAPD5,
    DIALOG_SAPD6,
    DIALOG_SAPD7,
	BISNIS_SONG,
	BISNIS_PH,
	DIALOG_SELL_HOUSES,
	DIALOG_SELL_HOUSE,
	DIALOG_MY_HOUSES,
	DIALOG_SPAWNCARSAPD,
	HOUSE_INFO,
	HOUSE_STORAGE,
	HOUSE_WEAPONS,
	HOUSE_MONEY,
	HOUSE_REALMONEY,
	HOUSE_WITHDRAW_REALMONEY,
	HOUSE_DEPOSIT_REALMONEY,
	HOUSE_REDMONEY,
	HOUSE_WITHDRAW_REDMONEY,
	HOUSE_DEPOSIT_REDMONEY,
	HOUSE_FOODDRINK,
	HOUSE_FOOD,
	HOUSE_FOOD_DEPOSIT,
	HOUSE_FOOD_WITHDRAW,
	HOUSE_DRINK,
	HOUSE_DRINK_DEPOSIT,
	HOUSE_DRINK_WITHDRAW,
	HOUSE_DRUGS,
	HOUSE_MEDICINE,
	HOUSE_MEDICINE_DEPOSIT,
	HOUSE_MEDICINE_WITHDRAW,
	HOUSE_MEDKIT,
	HOUSE_MEDKIT_DEPOSIT,
	HOUSE_MEDKIT_WITHDRAW,
	HOUSE_BANDAGE,
	HOUSE_BANDAGE_DEPOSIT,
	HOUSE_BANDAGE_WITHDRAW,
	HOUSE_OTHER,
	HOUSE_SEED,
	//ayam
	DIALOG_AYAMFILL,
	DIALOG_AYAM,

	//Eprop
	DIALOG_EMOTEPROPERTY,

	//TD TRY
	DIALOG_TRYTD,

	HOUSE_SEED_DEPOSIT,
	HOUSE_SEED_WITHDRAW,
	HOUSE_MATERIAL,
	HOUSE_MATERIAL_DEPOSIT,
	HOUSE_MATERIAL_WITHDRAW,
	HOUSE_COMPONENT,
	HOUSE_COMPONENT_DEPOSIT,
	HOUSE_COMPONENT_WITHDRAW,
	HOUSE_MARIJUANA,
	HOUSE_MARIJUANA_DEPOSIT,
	HOUSE_MARIJUANA_WITHDRAW,
	DIALOG_FINDVEH,
	DIALOG_TRACKVEH,
	DIALOG_TRACKVEH2,
	//markisa
	DIALOG_SELL_MARKISA,

	//mdc
	DIALOG_TRACK,
	DIALOG_TRACK_PH,
	DIALOG_INFO_BIS,
	DIALOG_INFO_HOUSE,
	DIALOG_CUCIREDMONEY,
	//Tuning
	DIALOG_TUNING,
    DIALOG_TUNEBRAKE,
    DIALOG_TUNETURBO,
	DIALOG_VM,
    DIALOG_SAPD_GARAGE,
	//inventory
	DIALOG_GIVE,
	DIALOG_AMOUNT,
	//DEALER SYSTEM
	DIALOG_RENTBOAT,
	DIALOG_RENTBOAT_CONFIRM,
	DIALOG_RENTBIKES,
	DIALOG_RENTAL_CONFIRM,

	//objectstream
	DIALOG_STREAMER_CONFIG,
	//PAJAK
	DIALOG_PAYTAX,
	DIALOG_PAYTAX_BISNIS,
	DIALOG_PAYTAX_HOUSE,
	DIALOG_PAYTAX_DEALER,
	DIALOG_PAYTAX_VEHICLE,
    //DEALER
	DIALOG_BUYJOBCARSVEHICLE,
	DIALOG_BUYDEALERCARS_CONFIRM,
	DIALOG_BUYTRUCKVEHICLE,
	DIALOG_BUYMOTORCYCLEVEHICLE,
	DIALOG_BUYUCARSVEHICLE,
	DIALOG_BUYCARSVEHICLE,
	DIALOG_DEALER_MANAGE,
	DIALOG_DEALER_VAULT,
	DIALOG_DEALER_WITHDRAW,
	DIALOG_DEALER_DEPOSIT,
	DIALOG_DEALER_NAME,
	DIALOG_DEALER_RESTOCK,
	DIALOG_FIND_DEALER,
	//idcard
	DIALOG_SHOW_IDCARD,

	DIALOG_TRACKPARKEDVEH,
	DIALOG_GOTOVEH,
	DIALOG_GETVEH,
	DIALOG_DELETEVEH,
	DIALOG_BUYPV,
	DIALOG_BUYVIPPV,
	DIALOG_BUYPLATE,
	DIALOG_BUYPVCP,
	DIALOG_BUYPVCP_BIKES,
	DIALOG_BUYPVCP_CARS,
	DIALOG_BUYPVCP_UCARS,
	DIALOG_BUYPVCP_JOBCARS,
	DIALOG_BUYPVCP_VIPCARS,
	DIALOG_BUYPVCP_CONFIRM,
	DIALOG_BUYPVCP_VIPCONFIRM,
	DIALOG_RENT_JOBCARS,
	DIALOG_RENT_JOBCARSCONFIRM,
	DIALOG_RENT_BOAT,
	DIALOG_RENT_BOATCONFIRM,
	DIALOG_RENT_BIKE,
	DIALOG_RENT_BIKECONFIRM,

	//impound
	DIALOG_UNIMPOUND,

	//DIALOG_GARKOT,
	DIALOG_MY_VEHICLE,
	DIALOG_TOY,
	DIALOG_TOYEDIT,
	DIALOG_TOYEDIT_ANDROID,
	DIALOG_TOYPOSISI,
	DIALOG_TOYPOSISIBUY,
	DIALOG_TOYBUY,
	DIALOG_TOYVIP,
	DIALOG_TOYPOSX,
	DIALOG_TOYPOSY,
	DIALOG_TOYPOSZ,
	DIALOG_TOYPOSRX,
	DIALOG_TOYPOSRY,
	DIALOG_TOYPOSRZ,
	DIALOG_TOYPOSSX,
	DIALOG_TOYPOSSY,
	DIALOG_TOYPOSSZ,
	DIALOG_HELP,
	DIALOG_GPS,
	DIALOG_PAYBILL,
	DIALOG_RADIAL,
	DIALOG_ANIMRADIAL,
	DIALOG_ANIM,
	DIALOG_SALAMAN,
	DIALOG_JOB,
	DIALOG_GPS_JOB,
	DIALOG_GPS_PUBLIC,
	DIALOG_GPS_PROPERTIES,
	DIALOG_GPS_GENERAL,
	DIALOG_GPS_MISSION,
	DIALOG_TRACKBUSINESS,
	DIALOG_ELECTRONIC_TRACK,
	DIALOG_PAY,
	DIALOG_EDITBONE,
	FAMILY_SAFE,
	FAMILY_STORAGE,
	FAMILY_WEAPONS,
	FAMILY_MARIJUANA,
	FAMILY_WITHDRAWMARIJUANA,
	FAMILY_DEPOSITMARIJUANA,
	FAMILY_COMPONENT,
	FAMILY_WITHDRAWCOMPONENT,
	FAMILY_DEPOSITCOMPONENT,
	FAMILY_MATERIAL,
	FAMILY_WITHDRAWMATERIAL,
	FAMILY_DEPOSITMATERIAL,
	FAMILY_MONEY,
	FAMILY_WITHDRAWMONEY,
	FAMILY_DEPOSITMONEY,
	FAMILY_INFO,
	DIALOG_SERVERMONEY,
	DIALOG_SERVERMONEY_STORAGE,
	DIALOG_SERVERMONEY_WITHDRAW,
	DIALOG_SERVERMONEY_DEPOSIT,
	DIALOG_SERVERMONEY_REASON,

	DIALOG_TRACK_GARKOT,
	MENCET_DISNAKER,
	DIALOG_DISNAKER2,

	//
	DIALOG_BANKMD,
	DIALOG_BANKMD_STORAGE,
	DIALOG_BANKMD_WITHDRAW,
	DIALOG_BANKMD_DEPOSIT,
	DIALOG_BANKMD_REASON,

	//gocar bank
	DIALOG_BANKGO,
	DIALOG_BANKGO_STORAGE,
	DIALOG_BANKGO_WITHDRAW,
	DIALOG_BANKGO_DEPOSIT,
	DIALOG_BANKGO_REASON,

	//sanews bank
	DIALOG_BANKSA,
	DIALOG_BANKSA_STORAGE,
	DIALOG_BANKSA_WITHDRAW,
	DIALOG_BANKSA_DEPOSIT,
	DIALOG_BANKSA_REASON,
	//SAPD BANK
	DIALOG_BANKPD,
	DIALOG_BANKPD_STORAGE,
	DIALOG_BANKPD_WITHDRAW,
	DIALOG_BANKPD_DEPOSIT,
	DIALOG_BANKPD_REASON,
	DIALOG_LOCKERSAPD,
	DIALOG_WEAPONSAPD,
	DIALOG_LOCKERSAGS,
	DIALOG_WEAPONSAGS,
	DIALOG_LOCKERSAMD,
	DIALOG_WEAPONSAMD,
	DIALOG_DRUGSSAMD,
	DIALOG_LOCKERSANEW,
	DIALOG_WEAPONSANEW,
	DIALOG_LOCKERVIP,
	DIALOG_SERVICE,
	DIALOG_SERVICE_COLOR,
	DIALOG_SERVICE_COLOR2,
	DIALOG_SERVICE_PAINTJOB,
	DIALOG_SERVICE_WHEELS,
	DIALOG_TUNE_WHEELS,
	DIALOG_SERVICE_SPOILER,
	DIALOG_SERVICE_HOODS,
	DIALOG_SERVICE_VENTS,
	DIALOG_SERVICE_LIGHTS,
	DIALOG_SERVICE_EXHAUSTS,
	DIALOG_SERVICE_FRONT_BUMPERS,
	DIALOG_SERVICE_REAR_BUMPERS,
	DIALOG_ALOGIN,
	DIALOG_SERVICE_ROOFS,
	DIALOG_SERVICE_SIDE_SKIRTS,
	DIALOG_SERVICE_BULLBARS,
	DIALOG_SERVICE_NEON,
	DIALOG_MENU_TRUCKER,
	DIALOG_SHIPMENTS,
	DIALOG_SHIPMENTS_VENDING,
	DIALOG_HAULING,
	DIALOG_CRATES,
	DIALOG_CRATE_EXPORT,
	DIALOG_MERCHANTFILLER,
	DIALOG_RESTOCK,
	DIALOG_RESTOCK_VENDING,
	DIALOG_ARMS_GUN,
	DIALOG_PLANT,
	DIALOG_PFLANT,
	DIALOG_EDIT_PRICE,
	DIALOG_EDIT_PRICE1,
	DIALOG_EDIT_PRICE2,
	DIALOG_EDIT_PRICE3,
	DIALOG_EDIT_PRICE4,
	DIALOG_OFFER,
	DIALOG_MATERIAL,
	DIALOG_COMPONENT,
	DIALOG_DRUGS,
	DIALOG_FOOD,
	DIALOG_CHANGELOGS,
	DIALOG_FOOD_BUY,
	DIALOG_SEED_BUY,
	DIALOG_PRODUCT,
	DIALOG_GASOIL,
	DIALOG_APOTEK,
	DIALOG_ATM,
	DIALOG_TRACKATM,
	DIALOG_ATMWITHDRAW,
	DIALOG_BANK,
	DIALOG_BANKDEPOSIT,
	DIALOG_BANKWITHDRAW,
	DIALOG_BANKREKENING,
	DIALOG_BANKTRANSFER,
	DIALOG_BANKCONFIRM,
	DIALOG_BANKSUKSES,
	DIALOG_PHONE,
	DIALOG_TWITTER,
	DIALOG_TWITTERPOST,
	DIALOG_TWITTERNAME,
	TWEET_APP,
	TWEET_SIGNUP,
	TWEET_CHANGENAME,
	TWEET_ACCEPT_CHANGENAME,
	DIALOG_TWEETMODE,
	PHONE_NOTIF,
	DIALOG_PHONE_ADDCONTACT,
	DIALOG_PHONE_CONTACT,
	DIALOG_PHONE_NEWCONTACT,
	DIALOG_PHONE_INFOCONTACT,
	DIALOG_PHONE_SENDSMS,
	DIALOG_PHONE_TEXTSMS,
	DIALOG_PHONE_DIALUMBER,
	DIALOG_TOGGLEPHONE,
	DIALOG_IBANK,
	DIALOG_REPORTS,
	DIALOG_ANSWER_REPORTS,
	DIALOG_ASKS,
	DIALOG_SALARY,
	DIALOG_PAYCHECK,
	DIALOG_SWEEPER,
	DIALOG_STREAK,
	DIALOG_PIZZA,
	DIALOG_BUS,
	DIALOG_FORKLIFT,
	DIALOG_MOWER,
	DIALOG_RUTE_SWEEPER,
	DIALOG_RUTE_STREAK,
	DIALOG_RUTE_BUS,
	DIALOG_BAGGAGE,
	DIALOG_HEALTH,
	DIALOG_OBAT,
	DIALOG_ISIKUOTA,
	DIALOG_DOWNLOAD,
	DIALOG_KUOTA,
	DIALOG_STUCK,
	DIALOG_TDM,
	DIALOG_PICKUPVEH,
	DIALOG_TRACKPARK,
	DIALOG_MY_WS,
	DIALOG_MY_GARAGE,
	DIALOG_TRACKWS,
	DIALOG_TRACKDEALERSHIP,
	WS_MENU,
	WS_SETNAME,
	WS_SETOWNER,
	WS_SETEMPLOYE,
	WS_SETEMPLOYEE,
	WS_SETOWNERCONFIRM,
	WS_SETMEMBER,
	WS_SETMEMBERE,
	WS_MONEY,
	WS_WITHDRAWMONEY,
	WS_DEPOSITMONEY,
	WS_COMPONENT,
	WS_COMPONENT2,
	WS_MATERIAL,
	WS_MATERIAL2,
	//Ladang
	DIALOG_MY_OP,
	DIALOG_TRACKOP,
	OP_MENU,
	OP_SETNAME,
	OP_SETOWNER,
	OP_SETEMPLOYE,
	OP_SETEMPLOYEE,
	OP_SETOWNERCONFIRM,
	OP_SETMEMBER,
	OP_SETMEMBERE,
	OP_MONEY,
	OP_WITHDRAWMONEY,
	OP_DEPOSITMONEY,
	OP_SEEDS,
	OP_SEEDS2,
	OP_MARIJUANA,
	OP_MARIJUANA2,
	DIALOG_REDMOGUN,
	DIALOG_ACTORANIM,
	DIALOG_MY_VENDING,
	DIALOG_VENDING_INFO,
	DIALOG_VENDING_BUYPROD,
	DIALOG_VENDING_MANAGE,
	DIALOG_VENDING_NAME,
	DIALOG_VENDING_VAULT,
	DIALOG_VENDING_WITHDRAW,
	DIALOG_VENDING_DEPOSIT,
	DIALOG_VENDING_EDITPROD,
	DIALOG_VENDING_PRICESET,
	DIALOG_VENDING_RESTOCK,
	DIALOG_SPAWN_1,
	DIALOG_MYVEH,
	DIALOG_MYVEH_INFO,
	DIALOG_FAMILY_INTERIOR,
	DIALOG_SPAREPART,
	DIALOG_BUYPARTS,
	DIALOG_BUYPARTS_DONE,
	VEHICLE_STORAGE,
	VEHICLE_WEAPON,
	VEHICLE_MONEY,
	VEHICLE_REALMONEY,
	VEHICLE_REALMONEY_WITHDRAW,
	VEHICLE_REALMONEY_DEPOSIT,
	VEHICLE_REDMONEY,
	VEHICLE_REDMONEY_WITHDRAW,
	VEHICLE_REDMONEY_DEPOSIT,
	VEHICLE_DRUGS,
	VEHICLE_MEDICINE,
	VEHICLE_MEDICINE_WITHDRAW,
	VEHICLE_MEDICINE_DEPOSIT,
	VEHICLE_MEDKIT,
	VEHICLE_MEDKIT_WITHDRAW,
	VEHICLE_MEDKIT_DEPOSIT,
	VEHICLE_BANDAGE,
	VEHICLE_BANDAGE_WITHDRAW,
	VEHICLE_BANDAGE_DEPOSIT,
	VEHICLE_OTHER,
	VEHICLE_SEED,
	VEHICLE_SEED_WITHDRAW,
	VEHICLE_SEED_DEPOSIT,
	VEHICLE_MATERIAL,
	VEHICLE_MATERIAL_WITHDRAW,
	VEHICLE_MATERIAL_DEPOSIT,
	VEHICLE_COMPONENT,
	VEHICLE_COMPONENT_WITHDRAW,
	VEHICLE_COMPONENT_DEPOSIT,
	VEHICLE_MARIJUANA,
	VEHICLE_MARIJUANA_WITHDRAW,
	VEHICLE_MARIJUANA_DEPOSIT,
	DIALOG_NONRPNAME,
	DIALOG_PICKUPVEH_GARAGE,
	DIALOG_GARAGE,
	//micin
	DIALOG_MICIN,
	//locktire
	DIALOG_LOCKTIRE,
	//houseclip
	HOUSE_CLIPA,
	HOUSE_CLIPB,
	HOUSE_CLIPC,
	HOUSE_DEPOSITCLIPA,
	HOUSE_WITHDRAWCLIPA,
	HOUSE_DEPOSITCLIPB,
	HOUSE_WITHDRAWCLIPB,
	HOUSE_WITHDRAWCLIPC,
	HOUSE_DEPOSITCLIPC,
	//gym
	DIALOG_FSTYLE,
	DIALOG_GMENU,
	//gasstation
	GAS_VAULT,
	GAS_DEPOSIT,
	GAS_WITHDRAW,
	GAS_PRICESET,
	GAS_MENU,
	GAS_INFO,
	GAS_NAME,
	//vip
	DIALOG_VIPMENU,
	DIALOG_NEWPHONE,
	DIALOG_NEWREK,
	DIALOG_NEWMASK,
	//pemadam
	DIALOG_PEMADAM,
	//Vehicle Toys
	DIALOG_MMENU,
	DIALOG_VTOY,
	DIALOG_VTOYBUY,
	DIALOG_VTOYEDIT,
	DIALOG_VTOYPOSX,
	DIALOG_VTOYPOSY,
	DIALOG_VTOYPOSZ,
	DIALOG_VTOYPOSRX,
	DIALOG_VTOYPOSRY,
	DIALOG_VTOYPOSRZ,
	DIALOG_ENTER_VALUE,
	//toys
	VSELECT_POS,
	VTOYSET_VALUE,
	VTOYSET_COLOUR,
	VTOY_ACCEPT,
	TuneVehicle,
	AddNOS,
	DIALOG_TPADMIN,
	//boombox
	DIALOG_BOOMBOX1,
	DIALOG_BOOMBOX,
	DIALOG_MUSICHP,
	DIALOG_MUSICHP2,
	DIALOG_IKLANHP,
	DIALOG_ADMIN_SIGNAL,
	//DIALOG_BOOMBOX_URL,
	//DIALOG_BOOMBOX_LIST,
	/*DIALOG_FLATGPS,
	DIALOG_FLAT,
	DIALOG_FLATCASH,
	DIALOG_FCWD,
	DIALOG_FCDP,
	DIALOG_FLATWEAPON,*/
	DIALOG_MODSHOP,
	DIALOG_MODEDIT,
	// MODSHOPnew
	DIALOG_MODMENU,
	DIALOG_MODTOY,
	DIALOG_MODTBUY,
	DIALOG_MODTEDIT,
	DIALOG_MODTPOSX,
	DIALOG_MODTPOSY,
	DIALOG_MODTPOSZ,
	DIALOG_MODTPOSRX,
	DIALOG_MODTPOSRY,
	DIALOG_MODTPOSRZ,
	DIALOG_MODTSELECTPOS,
	DIALOG_MODTSETVALUE,
	DIALOG_MODTSETCOLOUR,
	DIALOG_MODTSETPOS,
	DIALOG_MODTACCEPT,

	//--[Dialog Graffity]--
	DIALOG_WELCOME,
	DIALOG_SELECT,
	DIALOG_INPUTGRAFF,
	DIALOG_COLOR,
	DIALOG_HAPPY,
	DIALOG_LIST,
	BUY_SPRAYCAN,
	DIALOG_GOMENU,
	DIALOG_GDOBJECT,
	MODEL_SELECTION_MODSHOP,
	MODEL_SELECTION_MODSHOP2,
	//pedagang
	DIALOG_LOCKERPEDAGANG,
	DIALOG_GUDANGPEDAGANG,
	DIALOG_TAKEFOOD,
	DIALOG_LISTVEHGO,
	DIALOG_MOTORCYCLEGO,
	DIALOG_CARGO,
	DIALOG_MENUMASAK,
	DIALOG_MENU,
	DIALOG_CALLGOCAR,
	//jobnambang
	DIALOG_LOCKERPENAMBANG,
	DIALOG_LOCKERMINYAK,
	DIALOG_GPS_MINYAK,
	DIALOG_GPS_PENAMBANG,
	//spawnsamd
    DIALOG_SAMD_GARAGE,
	//radialnew
	DIALOG_DOKUMEN,
	//clipreload
	DIALOG_CLIP,
	DIALOG_BELICLIP,
	DIALOG_SANA_GARAGE,
	DIALOG_SAGS_GARAGE,
	CAR_MENU,
	DIALOG_TAMBANG,

}

//STATIC SAMD
new SAMDVeh[MAX_PLAYERS];
//coldown sistem
new detikcd = -1;
//-----[ Download System ]-----
new download[MAX_PLAYERS];
//skin
new PEDMale = mS_INVALID_LISTID,
	PEDFemale = mS_INVALID_LISTID;
//-----[ Count System ]-----
new Count = -1;
new countTimer;
new showCD[MAX_PLAYERS];
new CountText[5][5] =
{
	"~r~1",
	"~g~2",
	"~y~3",
	"~g~4",
	"~b~5"
};

//-----[ Rob System ]-----
new robmoney;

//-----[ Server Uptime ]-----
new up_days,
	up_hours,
	up_minutes,
	up_seconds,
	WorldTime = 10,
	WorldWeather = 24;

//-----[ Faction Vehicle ]-----	
#define VEHICLE_RESPAWN 7200

// new GOCARVehicles[30];
	// SAPDVehicles[30],
	// SAGSVehicles[30],
	// SAMDVehicles[30],
	// SANAVehicles[30],


// IsGovCar(carid)
// {
// 	for(new v = 0; v < sizeof(SAGSVehicles); v++)
// 	{
// 	    if(carid == SAGSVehicles[v]) return 1;
// 	}
// 	return 0;
// }

// IsSAMDCar(carid)
// {
// 	for(new v = 0; v < sizeof(SAMDVehicles); v++)
// 	{
// 	    if(carid == SAMDVehicles[v]) return 1;
// 	}
// 	return 0;
// }

// IsSANACar(carid)
// {
// 	for(new v = 0; v < sizeof(SANAVehicles); v++)
// 	{
// 	    if(carid == SANAVehicles[v]) return 1;
// 	}
// 	return 0;
// }

// IsGOCARCar(carid)
// {
// 	for(new v = 0; v < sizeof(GOCARVehicles); v++)
// 	{
// 	    if(carid == GOCARVehicles[v]) return 1;
// 	}
// 	return 0;
// }



new DutyTimer;
new MalingKendaraan;


//-----[ Button ]-----	
new SAGSLobbyBtn[8],
	SAGSLobbyDoor[4],
	SAMCLobbyBtn[6],
	SAMCLobbyDoor[3],
	SAPDLobbyBtn[6],
	SAPDLobbyDoor[3];
//-----[ MySQL Connect ]-----	
new MySQL: g_SQL;

new TogOOC = 1;

//-----[ Player Data ]-----	
enum E_PLAYERS
{
	pID,
	pTweet,
	pTogTweet,
	pTname[MAX_PLAYER_NAME],
	pUCP[22],
	//nikah/blm
	pSudahNikah,
	//disconnectnew
	pLabelDisconnect,
	pExtraChar,
	pChar,
	pCharacterStory,
	pName[MAX_PLAYER_NAME],
	pAdminname[MAX_PLAYER_NAME],
	pIP[16],
	pVerifyCode,
	pAdminPin,
	pAloginSucces,
	pPassword[65],
	pSalt[17],
	pEmail[40],
	pMenikah[MAX_PLAYER_NAME],
	pMelamar,
	pAdmin,
	pHelper,
	pLevel,
	pLevelUp,
	pVip,
	pVipTime,
	pGold,
	pRegDate[50],
	pLastLogin[50],
	pMoney,
	pRedMoney,
	//Badge
	pBadge,
	pBadgeNumber[50],
	//Text3D:pMaskLabel,
	STREAMER_TAG_3D_TEXT_LABEL:pMaskLabel,
	STREAMER_TAG_3D_TEXT_LABEL:pNameTag,
	pBankMoney,
	pBankRek,
	pLockPick,
	BankDelay,
	pRobStatus,
	RobbankTime,
	RobatmTime,
	RobbizTime,
	pPhone,
	pPhoneCredit,
	pContact,
	pPhoneBook,
	//Markisa Jobs
	pMarkisa,
	pProsesMarkisa,
	pProsesMarkisaStatus,
	pMarkisaSeed,
	pProsesPabrik,
	pMarkisaTime,
	//Berry Farmers
	EditingBerryID,
	HarvestBerryID,
	pBerry,
	pSMS,
	pCall,
	pCallTime,
	pWT,
	pHours,
	pMinutes,
	pSeconds,
	pPaycheck,
	//pInsukel,
	pSkin,
	pFacSkin,
	pGender,
	pAge[50],
	pInDoor,
	pInHouse,
	pInDealer,
	pDealerMission,
	pInBiz,
	pInVending,
	pInFamily,
	Float: pPosX,
	Float: pPosY,
	Float: pPosZ,
	Float: pPosA,
	Float:pPos[4],
	pInt,
	pWorld,
	Float:pHealth,
    Float:pArmour,
	pHunger,
	pEnergy,
	pHungerTime,
	pEnergyTime,
	pSick,
	pVoteyes,
	pVoteno,
	pSickTime,
	pHospital,
	pHospitalTime,
	pInjured,
	Text3D: pInjuredLabel,
	pOnDuty,
	pOnDutyTime,
	pFaction,
	pFactionRank,
	pFactionLead,
	pTazer,
	pBroadcast,
	pNewsGuest,
	pFamily,
	pFamilyRank,
	pJail,
	pJailTime,
	pArrest,
	pArrestTime,
	pWarn,
	pFarm,
	pFarmRank,
	pFarmInvite,
	pFarmOffer,
	//livemode
	pLiveText,
	pLiveChannel,
	//spawn faction
	pFactionVeh,
	pCoin,
	pJob,
	pJob2,
	pJobTime,
	pExitJob,
	pMedicine,
	pTeriakSignal,
	pMedkit,
	pMask,
	pHelmet,
	pSnack,
	pSprunk,
	pGas,
	pIssueText,
	pBandage,
	pGPS,
	pGpsActive,
	pTargetVehicle,
	pMaterial,
	pComponent,
	EditingSIGNAL,
	pFood,
	pFrozenPizza,
	pSeed,
	pDelaySpawn,
	pPotato,
	pWheat,
	pOrange,
	pPrice1,
	pPrice2,
	pPrice3,
	pPrice4,
	pMarijuana,
	pPlant,
	pPlantTime,
	pFishTool,
	pWorm,
	pFish,
	pInFish,
	pIDCard,
	pIDCardTime,
	pBobolTime,
	pBpjs,
	pBpjsTime,
	pDriveLic,
	pDriveLicTime,
	pDriveLicApp,
	pBoatLic,
	pBoatLicTime,
	pWeaponLic,
	pWeaponLicTime,
	pFlyLic,
	pFlyLicTime,
	pGuns[13],
    pAmmo[13],
	pWeapon,
	pBotol,
	//Not Save
	Text3D:AdminTag,
	Cache:Cache_ID,
	bool: IsLoggedIn,
	LoginAttempts,
	LoginTimer,
	pSpawned,
	pSpawnList,
	pAdminDuty,
	pFreezeTimer,
	pFreeze,
	pMaskID,
	pMaskOn,
	pTogVip,
	pBlindfold,
	pInBlindfold,
	pSPY,
	pToggleAtm,
	pDelayPm,
	pDelayWT,
	pTogPM,
	pTogLog,
	pTogDweb,
	pTogAntichit,
	pTogAds,
	pTogWT,
	Text3D:pAdoTag,
	Text3D:pBTag,
	bool:pBActive,
	bool:pAdoActive,
	pFlare,
	bool:pFlareActive,
	bool:TempatHealing,
	pTrackCar,
	pTimeChit,
	pBuyPvModel,
	pTrackHouse,
	pTrackBisnis,
	pTrackVending,
	pFacInvite,
	pFacOffer,
	pFamInvite,
	pFamOffer,
	pFindEms,
	pCuffed,
	toySelected,
	bool:PurchasedToy,
	pEditingItem,
	EditStatus,
	VehicleID,
	//balapan
	pRaceWith,
	pRaceFinish,
	pRaceIndex,
	//wantedcrime
	pWanted,
	pWarrant1,
	pWarrant2,
	pWarrant3,
	pWarrant4,
	pWarrant5,
	pWarrant6,
	//engine
	pStartEn,
	//robrumah
	pBobolrumah,
	pAmbiltv,
	pIntbobol,
	pTv,
	pDancok,
	pLemari,
	//pemotong ayam
	pGetChicken,
	pChicken,
	pFryChicken,
	pGetChicken1,
	pChicken1,
	pFryChicken1,
	pPackingChicken1,
	//STUCK
	pStuck,

	timerambilayamhidup,
    timerpotongayam,
    timerpackagingayam,
    timerjualayam,
    AyamHidup,
	AyamPotong,
	AyamFillet,
	sedangambilayam,
    sedangpotongayam,
    sedangfilletayam,
    sedangjualayam,
	pPemotongStatus,
	//Graffity
	EditingGraffity,
	pProductModify,
	pEditingVendingItem,
	pVendingProductModify,
	pCurrSeconds,
	pCurrMinutes,
	pCurrHours,
	pSpec,
	playerSpectated,
	pFriskOffer,
	pDragged,
	pDraggedBy,
	pDragTimer,
	pHBEMode,
	pFightStyle,
	pGymVip,
	pFitnessTimer,
	pFitnessType,
	pHelmetOn,
	pSeatBelt,
	pReportTime,
	pAskTime,
	//Player Progress Bar
	PlayerBar:spfuelbar,
	PlayerBar:spdamagebar,
	PlayerBar:sphungrybar,
	PlayerBar:spenergybar,
	PlayerBar:activitybar,
	PlayerBar:hungrybar,
	PlayerBar:energybar,
	PlayerBar:bladdybar,
	PlayerBar:heathbar,
	PlayerBar:armorbar,
	// Modern
	PlayerBar:mdfuelbar,
	PlayerBar:mddamagebar,
	PlayerBar:mdhungrybar,
	PlayerBar:mdenergybar,
	pProducting,
	pProductingStatus,
	pGetMarkisa,
	pGetMarkisaStatus,
	pCooking,
	pCookingStatus,
	pArmsDealer,
	pArmsDealerStatus,
	pMechanic,
	pMechanicStatus,
	pActivity,
	pActivityStatus,
	pActivityTime,
	//anticheat
	pChainshaw,
	pHandHits,
	//waypoint
	pWaypoint,
	pLocation[32],
	Float:pWaypointPos[3],
	PlayerText:pTextdraws[83],
	//Jobs
	pSideJob,
	pSideJobTime,
	pSweeperTime,
	pStreak,
	pStreakTime,
	pPizzaTime,
	pForklifterTime,
	pBusTime,
	pBustime,
	bool:pBuswaiting,
	pMowerTime,
	pGetJob,
	pGetJob2,
	pTaxiDuty,
	pTaxiTime,
	pFare,
	pFareTimer,
	pTotalFare,
	Float:pFareOldX,
	Float:pFareOldY,
	Float:pFareOldZ,
	Float:pFareNewX,
	Float:pFareNewY,
	Float:pFareNewZ,
	pMechDuty,
	pMechVeh,
	pMechColor1,
	pMechColor2,
	pSpawnSana,
	pSpawnSags,
	//pedagang
	pNasi,
	pBurger,
	pAGoreng,
	pKebab,
	pSusu,
	//pemeras susu
	//musik veh
	pVehSong,
	pJobmilkduty,
	pMilkJob,
	pOlahMilk,
	pSusuOlahan,
	pSusuMentah,
	//Skill
	pTruckSkill,
	pMechSkill,
	pSmuggSkill,
	//ATM
	EditingATMID,
	//lumber job
	EditingTreeID,
	CuttingTreeID,
	bool:CarryingLumber,
	//jobbaru
	bool:DutyPenambang,
	bool:DutyMinyak,
	//Penambang
	pTimeTambang1,
	pTimeTambang2,
	pTimeTambang3,
	pTimeTambang4,
	pTimeTambang5,
	pTimeTambang6,
	//PENAMBANG
	pDutyJob,
	pBatu,
	pBatuCucian,
	pEmas,
	pBesi,
	pAluminium,
	//PENAMBANGMINYAK
	pMinyak,
	pEssence,
	pProgress,
	//Miner job
	//EditingOreID,
	//MiningOreID,
	//CarryingLog,
	//LoadingPoint,
	//inventory
	WaktuWarung,
	pPeluru[2],
	pDe,
	pKatana,
	pMolotov,
	p9mm,
	pSg,
	pSpas,
	pMp5,
	pM4,
	pSelectItem,
	pTarget,
	pGiveAmount,
	sampahsaya,
	//vtoys
	EditingVtoys,
	Float:pValue,
	//Vending
	EditingVending,
	pRokok,
	//pEditFlat,
	//key
	pVehKey,
	//production
	CarryProduct,
	//trucker
	pTruckerTime,
	pMission,
	pHauling,
	pVendingRestock,
	bool: CarryingBox,
	//Farmer
	pHarvest,
	pHarvestID,
	pOffer,
	pBladder,
	pBladderTime,
	//Rental
	pInRental,
	pGetRENID,
	//Mark
	pMarkTemp,
	//Bank
	pTransfer,
	pTransferRek,
	pTransferName[128],
	//Gas Station
	pFill,
	pFillStatus,
	pFillTime,
	pFillPrice,
	pInGas,
	//Gate
	gEditID,
	gEdit,
	// WBR
	pHead,
 	pPerut,
 	pLHand,
 	pRHand,
 	pLFoot,
 	pRFoot,
 	// Inspect Offer
 	pInsOffer,
	//kanabis
	pKanabis,
 	// Obat System
 	pObat,
 	// Suspect
 	pSuspectTimer,
 	pSuspect,
 	// Phone On Off
 	pPhoneStatus,
 	// Kurir
 	pKurirEnd,
 	// Shareloc Offer
 	pLocOffer,
 	// Twitter
 	pTwitter,
	pTwitterStatus, 
	pTwittername[MAX_PLAYER_NAME],
	pTwitterPostCooldown,
	pTwitterNameCooldown,
 	pRegTwitter,
 	// Kuota
 	pKuota,
 	// DUTY SYSTEM
 	pDutyHour,
 	//setfam
 	pHandleFam,
 	// CHECKPOINT
 	pCP,
 	// ROBBERY
 	pRob,
 	pRobTime,
 	pRobOffer,
 	pRobLeader,
 	pRobMember,
 	pMemberRob,
	pTrailer,
	pSudahHauling,
	// Smuggler
	bool:pTakePacket,
	pTrackPacket,
		//Smuggler
	//pSmugglerTimer,
	//pPacket,
	// Garkot
	pGetPARKID,
	EditingGarkot,
	pPark,
	pLoc,
	// WS
	pMenuType,
	pInWs,
	pTransferWS,
	//Ladang
	pMenuLadang,
	pInOp,
	pTransferOp,
	//Baggage
	pBaggage,
	pDelayBaggage,
	pTrailerBaggage,
	//Anticheat
	pACWarns,
	pACTime,
	pJetpack,
	pArmorTime,
	pLastUpdate,
	//Checkpoint
	pCheckPoint,
	pBus,
	pSweeper,
	pMower,
	//clipreload
	pClipA,
	pClipB,
	pClipC,
	//SAPD VEH
	pSpawnSapd,
	pSpawnSamd,
	pSpawnGo,
	//SpeedCam
 	EditingSPEEDCAM,
	//slotslenz
	pSlotMachine,
	EditingSlotID,
	//trash
	EditingTrash,
 	TimerSpeedcam,
	//pSpeedTime,
	pLumberTime,
	//Forklifter New System
	pForklifter,
	pForklifterLoad,
	pForklifterLoadStatus,
	pForklifterUnLoad,
	pForklifterUnLoadStatus,
	//Starterpack
	pStarterpack,
	pSpecial10k,
	//inventory calon
	//pProgress,
	//Anim
	pLoopAnim,
	// Crates Job
	pGetcrateFish[MAX_PLAYERS],
	//mt
	pRestart,
	// Job Micin
	pMicin,
	pPaketMicin,
	pProsesMicin,
	//Rob Car
	pLastChop,
	pLastChopTime,
	pIsStealing,
	//Sparepart
	pSparepart,
	//radio
	pRadio,
	pUangKorup,
	pPdKorup,
	pMdKorup,
	pSaKorup,
	pGoKorup,
	//characterlist
	pilihkarakter,
	//Senter
	pFlashlight,
	pUsedFlashlight,
	//Moderator
	pServerModerator,
	pEventModerator,
	pFactionModerator,
	pFamilyModerator,
	//
	pPaintball,
	pPaintball2,
	//
	pDelayIklan,
	pGarage,
	//accent
	pAccent1,
	pAccent[80],
	pTogAccent,
	//nikahan
	pMarried,
	pMarriedTo[128],
	pTogMoney,
	pMarriedAccept,
	pMarriedCancel,
	//boombox
	pBoombox,
	PilihSpawn,
	pMusicType,
	pStreamType,
	bool:pTogMusic,
	pVehicle,
	pListitem,
	pPhoneOff,
	pOnline,
	Text3D:pCatTag,
};
new pData[MAX_PLAYERS][E_PLAYERS];
new g_MysqlRaceCheck[MAX_PLAYERS];


//new Online
//new online;

//-----[ Smuggler ]-----	

new Text3D:packetLabel,
	packetObj,
	Float:paX, 
	Float:paY, 
	Float:paZ;

//-----[ Forklifter Object ]-----	
new 
	VehicleObject[MAX_VEHICLES] = {-1, ...};

//-----[ Lumber Object Vehicle ]-----	
#define MAX_BOX 50
#define BOX_LIFETIME 100
#define BOX_LIMIT 8

enum    E_BOX
{
	boxDroppedBy[MAX_PLAYER_NAME],
	boxSeconds,
	boxObjID,
	boxTimer,
	boxType,
	Text3D: boxLabel
}
new BoxData[MAX_BOX][E_BOX],
	Iterator:Boxs<MAX_BOX>;

new
	BoxStorage[MAX_VEHICLES][BOX_LIMIT];

//-----[ Lumber Object Vehicle ]-----	
#define MAX_LUMBERS 50
#define LUMBER_LIFETIME 100
#define LUMBER_LIMIT 10

enum    E_LUMBER
{
	lumberDroppedBy[MAX_PLAYER_NAME],
	lumberSeconds,
	lumberObjID,
	lumberTimer,
	Text3D: lumberLabel
}
new LumberData[MAX_LUMBERS][E_LUMBER],
	Iterator:Lumbers<MAX_LUMBERS>;

new
	LumberObjects[MAX_VEHICLES][LUMBER_LIMIT];

	
new
	Float: LumberAttachOffsets[LUMBER_LIMIT][4] = {
	    {-0.223, -1.089, -0.230, -90.399},
		{-0.056, -1.091, -0.230, 90.399},
		{0.116, -1.092, -0.230, -90.399},
		{0.293, -1.088, -0.230, 90.399},
		{-0.123, -1.089, -0.099, -90.399},
		{0.043, -1.090, -0.099, 90.399},
		{0.216, -1.092, -0.099, -90.399},
		{-0.033, -1.090, 0.029, -90.399},
		{0.153, -1.089, 0.029, 90.399},
		{0.066, -1.091, 0.150, -90.399}
	};

//-----[ Ores Miner ]-----	
#define LOG_LIFETIME 100
#define LOG_LIMIT 10
#define MAX_LOG 100

enum    E_LOG
{
	bool:logExist,
	logType,
	logDroppedBy[MAX_PLAYER_NAME],
	logSeconds,
	logObjID,
	logTimer,
	Text3D:logLabel
}
//new LogData[MAX_LOG][E_LOG];

new
	LogStorage[MAX_VEHICLES][2];

//-----[ Trucker ]-----	
new VehProduct[MAX_VEHICLES];
new VehGasOil[MAX_VEHICLES];
//-----[ Baggage ]-----	
new bool:DialogBaggage[10];
new bool:MyBaggage[MAX_PLAYERS][10];

//-----[ Type Checkpoint ]-----	
enum
{
	CHECKPOINT_NONE = 0,
	CHECKPOINT_FORKLIFTER,
	CHECKPOINT_DRIVELIC,
	CHECKPOINT_SWEEPER,
	CHECKPOINT_STREAK,
	CHECKPOINT_BAGGAGE,
	CHECKPOINT_MOWER,
	CHECKPOINT_MISC,
	CHECKPOINT_BUS
}

//-----[ Storage Limit ]-----	
enum
{
	LIMIT_VMEDICINE,
	LIMIT_VMEDKIT,
 	LIMIT_VBANDAGE,
 	LIMIT_VSEED,
	LIMIT_VMATERIAL,
	LIMIT_VCOMPONENT,
	LIMIT_VMARIJUANA
};
//-----[ Storage Limit ]-----	
enum
{
	LIMIT_SNACK,
	LIMIT_SPRUNK,
	LIMIT_MEDICINE,
	LIMIT_MEDKIT,
 	LIMIT_BANDAGE,
 	LIMIT_SEED,
	LIMIT_MATERIAL,
	LIMIT_COMPONENT,
	LIMIT_MARIJUANA
};

//-----[ eSelection Define ]-----	
#define 	SPAWN_SKIN_MALE 		1
#define 	SPAWN_SKIN_FEMALE 		2
#define 	SHOP_SKIN_MALE 			3
#define 	SHOP_SKIN_FEMALE 		4
#define 	VIP_SKIN_MALE 			5
#define 	VIP_SKIN_FEMALE 		6
#define 	SAPD_SKIN_MALE 			7
#define 	SAPD_SKIN_FEMALE 		8
#define 	SAPD_SKIN_WAR 			9
#define 	SAGS_SKIN_MALE 			10
#define 	SAGS_SKIN_FEMALE 		11
#define 	SAMD_SKIN_MALE 			12
#define 	SAMD_SKIN_FEMALE 		13
#define 	SANA_SKIN_MALE 			14
#define 	SANA_SKIN_FEMALE 		15
#define 	GOCAR_SKIN_MALE 		16
#define 	GOCAR_SKIN_FEMALE 		17
#define 	TOYS_MODEL 				18
#define 	VIPTOYS_MODEL 			19
#define 	MODEL_SELECTION_WHEELS 	20


new SpawnSkinMale[] = 
{
	20, 21, 22, 23, 24, 25, 5, 6
};

new SpawnSkinFemale[] = 
{
	12, 13, 40, 41, 55, 56
};

new ShopSkinMale[] =
{
	1, 2, 3, 4, 5, 6, 7, 8, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33,
	34, 35, 36, 37, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 57, 58, 59, 60, 61, 62, 66, 68, 72, 73,
	78, 79, 80, 81, 82, 83, 84, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109,
	110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133,
	134, 135, 136, 137, 142, 143, 144, 146, 147, 153, 154, 155, 156, 158, 159, 160, 161, 162, 167, 168, 170,
	171, 173, 174, 175, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 200, 202, 203,
	204, 206, 208, 209, 210, 212, 213, 217, 220, 221, 222, 223, 228, 229, 230, 234, 235, 236, 239, 240, 241,
	242, 247, 248, 249, 250, 253, 254, 255, 258, 259, 260, 261, 262, 268, 272, 273, 289, 290, 291, 292, 293,
	294, 295, 296, 297, 299
};

new ShopSkinFemale[] =
{
	9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 63, 64, 65, 69, 75, 76, 77, 85, 88, 89, 90, 91, 92,
	93, 129, 130, 131, 138, 140, 141, 145, 148, 150, 151, 152, 157, 169, 178, 190, 191, 192, 193, 194, 195, 196,
	197, 198, 199, 201, 205, 207, 211, 214, 215, 216, 219, 224, 225, 226, 231, 232, 233, 237, 238, 243, 244, 245,
	246, 251, 256, 257, 263, 298
};

new SAPDSkinWar[] =
{
	121, 285, 286, 287, 117, 118, 165, 166
};

new SAPDSkinMale[] =
{
	280, 281, 282, 283, 284, 288, 300, 301, 302, 303, 304, 305, 310, 311, 165, 166
};

new SAPDSkinFemale[] =
{
	306, 307, 309, 148, 150
};

new SAGSSkinMale[] =
{
	171, 17, 71, 147, 187, 165, 166, 163, 164, 255, 295, 294, 303, 304, 305, 189, 253
};

new SAGSSkinFemale[] =
{
	9, 11, 76, 141, 150, 219, 169, 172, 194, 263
};

new SAMDSkinMale[] =
{
	70, 187, 303, 304, 305, 274, 275, 276, 277, 278, 279, 165, 71, 177
};

new SAMDSkinFemale[] =
{
	308, 76, 141, 148, 150, 169, 172, 194, 219
};

new SANASkinMale[] =
{
	171, 187, 189, 240, 303, 304, 305, 20, 59
};

new SANASkinFemale[] =
{
	172, 194, 211, 216, 219, 233, 11, 9
};

new GOCARSkinMale[] =
{
	215, 155, 168
};

new GOCARSkinFemale[] =
{
	119, 11, 141, 205
};

new ToysModel[] =
{
	19006, 19007, 19008, 19009, 19010, 19011, 19012, 19013, 19014, 19015, 19016, 19017, 19018, 19019, 19020, 19021, 19022,
	19023, 19024, 19025, 19026, 19027, 19028, 19029, 19030, 19031, 19032, 19033, 19034, 19035, 19801, 18891, 18892, 18893,
	18894, 18895, 18896, 18897, 18898, 18899, 18900, 18901, 18902, 18903, 18904, 18905, 18906, 18907, 18908, 18909, 18910,
	18911, 18912, 18913, 18914, 18915, 18916, 18917, 18918, 18919, 18920, 19036, 19037, 19038, 19557, 11704, 19472, 18974,
	19163, 19064, 19160, 19352, 19528, 19330, 19331, 18921, 18922, 18923, 18924, 18925, 18926, 18927, 18928, 18929, 18930,
	18931, 18932, 18933, 18934, 18935, 18939, 18940, 18941, 18942, 18943, 18944, 18945, 18946, 18947, 18948, 18949, 18950,
	18951, 18953, 18954, 18960, 18961, 19098, 19096, 18964, 18967, 18968, 18969, 19106, 19113, 19114, 19115, 18970, 18638,
	19553, 19558, 19554, 18971, 18972, 18973, 19101, 19116, 19117, 19118, 19119, 19120, 18952, 18645, 19039, 19040, 19041,
	19042, 19043, 19044, 19045, 19046, 19047, 19053, 19421, 19422, 19423, 19424, 19274, 19518, 19077, 19517, 19317, 19318,
	19319, 19520, 1550, 19592, 19621, 19622, 19623, 19624, 19625, 19626, 19555, 19556, 19469, 19085, 19559, 19904, 19942, 
	19944, 11745, 19773, 18639, 18640, 18641, 18635, 18633, 3028, 11745, 19142, 371, 19078, 19590, 3026, 19528, 325, 19065,
	19528, 18922, 18923, 19141, 18638, 1669, 18866,
};

new VipToysModel[] =
{
	19006, 19007, 19008, 19009, 19010, 19011, 19012, 19013, 19014, 19015, 19016, 19017, 19018, 19019, 19020, 19021, 19022,
	19023, 19024, 19025, 19026, 19027, 19028, 19029, 19030, 19031, 19032, 19033, 19034, 19035, 19801, 18891, 18892, 18893,
	18894, 18895, 18896, 18897, 18898, 18899, 18900, 18901, 18902, 18903, 18904, 18905, 18906, 18907, 18908, 18909, 18910,
	18911, 18912, 18913, 18914, 18915, 18916, 18917, 18918, 18919, 18920, 19036, 19037, 19038, 19557, 11704, 19472, 18974,
	19163, 19064, 19160, 19352, 19528, 19330, 19331, 18921, 18922, 18923, 18924, 18925, 18926, 18927, 18928, 18929, 18930,
	18931, 18932, 18933, 18934, 18935, 18939, 18940, 18941, 18942, 18943, 18944, 18945, 18946, 18947, 18948, 18949, 18950,
	18951, 18953, 18954, 18960, 18961, 19098, 19096, 18964, 18967, 18968, 18969, 19106, 19113, 19114, 19115, 18970, 18638,
	19553, 19558, 19554, 18971, 18972, 18973, 19101, 19116, 19117, 19118, 19119, 19120, 18952, 18645, 19039, 19040, 19041,
	19042, 19043, 19044, 19045, 19046, 19047, 19053, 19421, 19422, 19423, 19424, 19274, 19518, 19077, 19517, 19317, 19318,
	19319, 19520, 1550, 19592, 19621, 19622, 19623, 19624, 19625, 19626, 19555, 19556, 19469, 19085, 19559, 19904, 19942, 
	19944, 11745, 19773, 18639, 18640, 18641, 18635, 18633, 3028, 11745, 19142
};

new VipSkinMale[] =
{
	1, 2, 3, 4, 5, 6, 7, 8, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33,
	34, 35, 36, 37, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 57, 58, 59, 60, 61, 62, 66, 68, 72, 73,
	78, 79, 80, 81, 82, 83, 84, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109,
	110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133,
	134, 135, 136, 137, 142, 143, 144, 146, 147, 153, 154, 155, 156, 158, 159, 160, 161, 162, 167, 168, 170,
	171, 173, 174, 175, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 200, 202, 203,
	204, 206, 208, 209, 210, 212, 213, 217, 220, 221, 222, 223, 228, 229, 230, 234, 235, 236, 239, 240, 241,
	242, 247, 248, 249, 250, 253, 254, 255, 258, 259, 260, 261, 262, 268, 272, 273, 289, 290, 291, 292, 293,
	294, 295, 296, 297, 299
};

new VipSkinFemale[] =
{
	9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 63, 64, 65, 69, 75, 76, 77, 85, 88, 89, 90, 91, 92,
	93, 129, 130, 131, 138, 140, 141, 145, 148, 150, 151, 152, 157, 169, 178, 190, 191, 192, 193, 194, 195, 196,
	197, 198, 199, 201, 205, 207, 211, 214, 215, 216, 219, 224, 225, 226, 231, 232, 233, 237, 238, 243, 244, 245,
	246, 251, 256, 257, 263, 298
};



//-----[ Modular ]-----	
main() 
{
	SetTimer("onlineTimer", 1000, true);
	SetTimer("TDUpdates", 8000, true);
	//SetTimer("RandomFire", 1800000, true);
	//SetTimer("Lenz", 8000, true);
}
new bool:Warung;
#include "COLOR.inc"
#include "DIALOG.inc"
#include "DISCORD.inc"
#include "FUNCTION.inc"
#include "MAPPING.inc"
#include "NATIVE.inc"
#include "SERVER.inc"
#include "UCP.inc"

#include "CMD\ADMIN.inc"
#include "CMD\FACTION.inc"
#include "CMD\MONEYBAGS.inc"
#include "CMD\PLAYER.inc"
#include "CMD\ALIAS\ALIAS_ADMIN.inc"
#include "CMD\ALIAS\ALIAS_BUSINESS.inc"
#include "CMD\ALIAS\ALIAS_HOUSE.inc"
#include "CMD\ALIAS\ALIAS_PLAYER.inc"
#include "CMD\ALIAS\ALIAS_PRIVATE_VEHICLE.inc"

#include "DYNAMIC\ACTOR.inc"
#include "DYNAMIC\APARTEMENT.inc"
#include "DYNAMIC\ARMS_DEALER.inc"
#include "DYNAMIC\ATM.inc"
//#include "DYNAMIC\AUCTION.inc"
#include "DYNAMIC\BUSINESS.inc"
#include "DYNAMIC\DEALERSHIP.inc"
#include "DYNAMIC\DOOR.inc"
#include "DYNAMIC\GARKOT.inc"
#include "DYNAMIC\GAS_STATION.inc"
#include "DYNAMIC\GATE.inc"
#include "DYNAMIC\GREENZONE.inc"
#include "DYNAMIC\HOUSE.inc"
#include "DYNAMIC\LOCKER.inc"
#include "DYNAMIC\MODSHOP.inc"
#include "DYNAMIC\MODSHOPNEW.inc"
#include "DYNAMIC\PFARM.inc"
#include "DYNAMIC\RENT.inc"
#include "DYNAMIC\RENT2.inc"
#include "DYNAMIC\SPEEDCAM.inc"
#include "DYNAMIC\TRASH.inc"
#include "DYNAMIC\VENDING.inc"
#include "DYNAMIC\WORKSHOP.inc"

#include "FACTION\CRIME_RECORD.inc"
#include "FACTION\GOVERNMENT.inc"
#include "FACTION\MEDICAL_DEPARTMENT.inc"
#include "FACTION\NEWS_AGENCY.inc"
#include "FACTION\POLICE_DEPARTMENT.inc"
#include "FACTION\PD_MDC.inc"
#include "FACTION\PD_ROADBLOCK.inc"
#include "FACTION\PD_SPIKE.inc"
#include "FACTION\PD_TASER.inc"

#include "FEATURE\ADVERT.inc"
#include "FEATURE\ANIMS.inc"
#include "FEATURE\ANTI_DUALNAME.inc"
#include "FEATURE\ANTICHEAT.inc"
#include "FEATURE\AREA.inc"
#include "FEATURE\ASK.inc"
#include "FEATURE\BERRY.inc"
#include "FEATURE\BILLS.inc"
#include "FEATURE\CALLPHONE.inc"
#include "FEATURE\CANNABIS.inc"
#include "FEATURE\CONTACT.inc"
#include "FEATURE\DAMAGELOG.inc"
#include "FEATURE\DINI_SYSTEM_SAVE.inc"
#include "FEATURE\DMV.inc"
#include "FEATURE\EVENT.inc"
#include "FEATURE\FAMILY.inc"
#include "FEATURE\FLYMODE.inc"
#include "FEATURE\GRAFITY.inc"
#include "FEATURE\GYM.inc"
#include "FEATURE\HELMET.inc"
#include "FEATURE\INVENTORY.inc"
#include "FEATURE\MDC.inc"
#include "FEATURE\PLAYER_ISSUE.inc"
#include "FEATURE\PRIVATE_VEHICLE.inc"
#include "FEATURE\QUIZ.inc"
#include "FEATURE\REDMOGUN.inc"
#include "FEATURE\REPORT.inc"
#include "FEATURE\ROBBERY.inc"
#include "FEATURE\ROBBANK.inc"
#include "FEATURE\ROBWARUNG.inc"
#include "FEATURE\ROBHOUSE.inc"
#include "FEATURE\SALARY.inc"
#include "FEATURE\SIGNAL.inc"
#include "FEATURE\SIREN.inc"
#include "FEATURE\SLOT.inc"
#include "FEATURE\SLOT_MACHINE.inc"
#include "FEATURE\STREAMER.inc"
#include "FEATURE\TASK.inc"
#include "FEATURE\TOLL.inc"
#include "FEATURE\TOYS.inc"
#include "FEATURE\TUNE_ADMIN.inc"
#include "FEATURE\VOUCHER.inc"
#include "FEATURE\VSTORAGE.inc"
#include "FEATURE\WEAPON_ATTH.inc"
//#include "VPARA.pwn"
//#include "VTOYS.pwn"
//#include "CODE2.pwn"
// #include "Lottery-System.pwn"
//#include "GreenZone.pwn"
//#include "PRIVATE_GARAGE.pwn"
//#include "insu_kel.inc"

#include "JOB\BAGGAGE.inc"
#include "JOB\BUTCHER.inc"
#include "JOB\BUS.inc"
#include "JOB\CRATE.inc"
#include "JOB\FARMER.inc"
#include "JOB\FISHER.inc"
#include "JOB\FORKLIFT.inc"
#include "JOB\GOCAR.inc"
#include "JOB\LUMBERJACK.inc"
#include "JOB\MARKISA.inc"
#include "JOB\MECH.inc"
#include "JOB\MERCHANT_FILLER.inc"
#include "JOB\MICIN.inc"
#include "JOB\MOWER.inc"
#include "JOB\OIL_MINER.inc"
#include "JOB\STONE_MINERS.inc"
#include "JOB\PIZZA.inc"
#include "JOB\PRODUCTION.inc"
#include "JOB\SMUGGLER.inc"
#include "JOB\SWEEPER.inc"
#include "JOB\TAXI.inc"
#include "JOB\TRAIN.inc"
#include "JOB\TRUCKER.inc"
//#include "JOB\JOB_SAPI.pwn"
//#include "JOB\JOB_DRUG_SMUGGLER.pwn"
//#include "JOB\JOB_MINER.pwn"

#include "UI\KLIKTD.inc"
#include "UI\LOADINGPROGRESS.inc"
#include "UI\NOTIF.inc"
#include "UI\NOTIFICATION.inc"
#include "UI\NOTIFY.inc"
#include "UI\SHOWITEMBOX.inc"
#include "UI\TEXTDRAW.inc"
//#include "UI\NotifCylinder.inc"

//banknew
ShowDialogToPlayer(playerid, dialogid)
{
	    switch(dialogid)
	    {
	        case DIALOG_BANKWITHDRAW:
			{
                new mstr[512];
			    format(mstr, sizeof(mstr), "{F6F6F6}You have "LB_E"%s {F6F6F6}in your bank account.\n\nType in the amount you want to withdraw below:", FormatMoney(pData[playerid][pBankMoney]));
			    ShowPlayerDialog(playerid, DIALOG_BANKWITHDRAW, DIALOG_STYLE_INPUT, ""LB_E"Bank", mstr, "Withdraw", "Cancel");
			}
	        case DIALOG_BANKDEPOSIT:
			{
			    new mstr[512];
			    format(mstr, sizeof(mstr), "{F6F6F6}You have "LB_E"%s {F6F6F6}in bank account.\n\nType in the amount you want to deposit below:", FormatMoney(pData[playerid][pBankMoney]));
			    ShowPlayerDialog(playerid, DIALOG_BANKDEPOSIT, DIALOG_STYLE_INPUT, ""LB_E"Bank", mstr, "Deposit", "Cancel");
			}
			case DIALOG_BANKREKENING:
			{
				ShowPlayerDialog(playerid, DIALOG_BANKREKENING, DIALOG_STYLE_INPUT, ""LB_E"Bank", "Input Number Of The Money:", "Transfer", "Cancel");
			}
		}
	    return 1;
}

forward TambahDetikCall(playerid);
public TambahDetikCall(playerid)
{
	DetikCall[playerid] ++;

	if(DetikCall[playerid] == 60)
	{
		DetikCall[playerid] = 0;
		TambahMenitCall(playerid);
	}
}

forward TambahMenitCall(playerid);
public TambahMenitCall(playerid)
{
	MenitCall[playerid] ++;

	if(MenitCall[playerid] == 60)
	{
		MenitCall[playerid] = 0;
		TambahJamCall(playerid);
	}
}

forward TambahJamCall(playerid);
public TambahJamCall(playerid)
{
	JamCall[playerid] ++;

	if(JamCall[playerid] == 24)
	{
		JamCall[playerid] = 0;
	}
}
//-----[ Discord Status ]-----	
forward BotStatus();
public BotStatus()
{
    new h = 0, m = 0, secs = 0, statuz[256];
	h = floatround(upt / 3600);
	m = floatround((upt / 60) - (h * 60));
	secs = floatround(upt - ((h * 3600) + (m * 60)));
	upt++;
	//format(statuz,sizeof(statuz),"!register [nama ucp]");
	//format(statuz,sizeof(statuz),"Players : %d | %dh %02dm One Pride [ONLINE]", pemainic, h, m);
	format(statuz,sizeof(statuz),"%d/%d Kota | %02dJ %02dM %02dD Uptime | One Pride Roleplay", pemainic, GetMaxPlayers(), h, m, secs);
	DCC_SetBotActivity(statuz);

}
//enterdoor
public EnterDoor(playerid)
{
	if(IsPlayerConnected(playerid))
	foreach(new did : Doors)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]))
		{
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]))
		{
			return 1;
		}
	}
	return 0;
}

public EnterBisnis(playerid)
{
	if(IsPlayerConnected(playerid))
	foreach(new id : Bisnis)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.8, bData[id][bExtposX], bData[id][bExtposY], bData[id][bExtposZ]))
		{
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.8, bData[id][bIntposX], bData[id][bIntposY], bData[id][bIntposZ]))
		{
			return 1;
		}
	}
	return 0;
}

public EnterHouse(playerid)
{
	if(IsPlayerConnected(playerid))
	foreach(new hid : Houses)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.8, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
		{
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.8, hData[hid][hIntposX], hData[hid][hIntposY], hData[hid][hIntposZ]))
		{
			return 1;
		}
	}
	return 0;
}
new const RandomMessage[10][144] = {
	""LB_E"<!> "WHITE_E"Gunakan /dokterlokal untuk kembali dari pingsan saat tidak ada dokter dikota.!.",
    ""LB_E"<!> "WHITE_E"Gunakan '/help' untuk melihat berbagai command server!",
    ""LB_E"<!> "WHITE_E"Menemukan Masalah? Gunakan '/report' untuk melaporkannya.",
    ""LB_E"<!> "WHITE_E"Ingin Bertanya sesuatu? Gunakan '/ask'",
    ""LB_E"<!> "WHITE_E"Jika Anda Menemukan Kriminalitas Silahkan /call 911",
    ""LB_E"<!> "WHITE_E"Gunakan /changelog Untuk melihat update server",
    ""LB_E"<!> "WHITE_E"Jika Anda Ingin Butuh Bantuan Para Medic Silahkan /call 922",
    ""LB_E"<!> "WHITE_E"Jika Anda Ingin Memesan Makanan Atau Minuman Silahkan /call 955",
    ""LB_E"<!> "WHITE_E"Jika Anda Sedang Down Gunakan /teriak Agar SAMD Datang",
	""LB_E"<!> "WHITE_E"Gunakan '/stuck' jika kamu bug!"

};

ptask RandoMessages[900000](playerid) {
  new rand = random(10);
  SendClientMessageEx(playerid, -1, "%s", RandomMessage[rand], pemainic);
}
public DCC_OnMessageCreate(DCC_Message:message)
{
	new realMsg[100];
    DCC_GetMessageContent(message, realMsg, 100);
    new bool:IsBot;
    new DCC_Channel:g_Discord_Chat;
    g_Discord_Chat = DCC_FindChannelById("975446425058025512");
    new DCC_Channel:channel;
 	DCC_GetMessageChannel(message, channel);
    new DCC_User:author;
	DCC_GetMessageAuthor(message, author);
    DCC_IsUserBot(author, IsBot);
    if(channel == g_Discord_Chat && !IsBot) //!IsBot will block BOT's message in game
    {
        new user_name[32 + 1], str[152];
       	DCC_GetUserName(author, user_name, 32);
        format(str,sizeof(str), "{8a6cd1}[DISCORD] {aa1bb5}%s: {ffffff}%s", user_name, realMsg);
        SendClientMessageToAll(-1, str);
    }

    return 1;
}
function ClearActorAnim(aid)
{
	ClearActorAnimations(aid);
}

function RobWarung(playerid, tid)
{
	new value = 100 + random(50);
	for(new i = 0; i < MAX_ROBBERY; i++)
	{
  		if(IsPlayerInRangeOfPoint(playerid, 2.3, RobberyData[i][robberyX], RobberyData[i][robberyY], RobberyData[i][robberyZ]))
		{
			new aid;
			GivePlayerMoneyEx(playerid, value);
			new String[1280];
			format(String, sizeof String, "~r~Anda berhasil Mendapatkan Duit %s..!!", FormatMoney(value));
			GameTextForPlayer(playerid, String, 4000, 5);
		 	ApplyActorAnimation(aid, "ped", "cower",4.0,0,0,0,1,0);
		 	SetTimerEx("ClearActorAnim", 3000, false, "d", aid);
		 	PlayerPlaySound(playerid, 3401, RobberyData[i][robberyX], RobberyData[i][robberyY], RobberyData[i][robberyZ]);
		 	if(IsValidDynamic3DTextLabel(RobberyData[i][robberyText]))
		  	DestroyDynamic3DTextLabel(RobberyData[i][robberyText]);
		}
	}
}
function ladangrefresh(id)
{
	if(IsValidDynamicObject(PlantData[id][PlantObjID]))
            DestroyDynamicObject(PlantData[id][PlantObjID]);
        
    if(IsValidDynamicCP(PlantData[id][PlantCP]))
        DestroyDynamicCP(PlantData[id][PlantCP]);

    if(PlantData[id][PlantType] == 1)
    {
        PlantData[id][PlantObjID] = CreateDynamicObject(2195, PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ]-1.5, 0.0, 0.0, 0.0, -1, -1, -1, 500.0, 500.0, -1, 0);
        PlantData[id][PlantCP] = CreateDynamicCP(PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ], 2.0, 0, 0, -1, 2.0);
    }
    else if(PlantData[id][PlantType] == 2)
    {
        PlantData[id][PlantObjID] = CreateDynamicObject(2244, PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ]-1.0, 0.0, 0.0, 0.0, -1, -1, -1, 500.0, 500.0, -1, 0);
        PlantData[id][PlantCP] = CreateDynamicCP(PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ], 2.0, 0, 0, -1, 2.0);
    }
    else if(PlantData[id][PlantType] == 3)
    {
        PlantData[id][PlantObjID] = CreateDynamicObject(949, PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ]-1.0, 0.0, 0.0, 0.0, -1, -1, -1, 500.0, 500.0, -1, 0);
        PlantData[id][PlantCP] = CreateDynamicCP(PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ], 2.0, 0, 0, -1, 2.0);
    }
    else if(PlantData[id][PlantType] == 4)
    {
        PlantData[id][PlantObjID] = CreateDynamicObject(3409, PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ]-2.0, 0.0, 0.0, 0.0, -1, -1, -1, 500.0, 500.0, -1, 0);
        PlantData[id][PlantCP] = CreateDynamicCP(PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ], 2.0, 0, 0, -1, 2.0);
    }
    return 1;
}
public OnGameModeInit()
{
	//mysql_log(ALL);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    warnings{i} = 0;
	}

	//SetTimer("BotStatus", 1000, true);
	CreateSlotTextdraw();
	SetTimer("UpdateNametag", 1000, true);
	SetTimer("BotSOF", 1000, true);
	foreach(new id : Ladang)
	{
		SetTimerEx("ladangrefresh", 1000, true, "i", id);
	}
	
	new MySQLOpt: option_id = mysql_init_options();

	mysql_set_option(option_id, AUTO_RECONNECT, true);

	g_SQL = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE, option_id);
	if (g_SQL == MYSQL_INVALID_HANDLE || mysql_errno(g_SQL) != 0)
	{
		print("MySQL connection failed. Server is shutting down.");
		SendRconCommand("exit");
		return 1;
	}
	print("MySQL connection is successful.");

	mysql_tquery(g_SQL, "SELECT * FROM `server`", "LoadServer");
	mysql_tquery(g_SQL, "SELECT * FROM `doors`", "LoadDoors");
	mysql_tquery(g_SQL, "SELECT * FROM `familys`", "LoadFamilys");
	mysql_tquery(g_SQL, "SELECT * FROM `houses`", "LoadHouses");
	mysql_tquery(g_SQL, "SELECT * FROM `bisnis`", "LoadBisnis");
	mysql_tquery(g_SQL, "SELECT * FROM `lockers`", "LoadLockers");
	mysql_tquery(g_SQL, "SELECT * FROM `gstations`", "LoadGStations");
	mysql_tquery(g_SQL, "SELECT * FROM `atms`", "LoadATM");	
	//mysql_tquery(g_SQL, "SELECT * FROM `garage`", "LoadGarage");
	mysql_tquery(g_SQL, "SELECT * FROM `gates`", "LoadGates");
	mysql_tquery(g_SQL, "SELECT * FROM `dealership`", "LoadDealership", "");
	mysql_tquery(g_SQL, "SELECT * FROM `vouchers`", "LoadVouchers");
	mysql_tquery(g_SQL, "SELECT * FROM `trees`", "LoadTrees");
	// mysql_tquery(g_SQL, "SELECT * FROM `ores`", "LoadOres");
	mysql_tquery(g_SQL, "SELECT * FROM `plants`", "LoadPlants");
	mysql_tquery(g_SQL, "SELECT * FROM `workshop`", "LoadWorkshop");
	//mysql_tquery(g_SQL, "SELECT * FROM `parks`", "LoadPark");
	mysql_tquery(g_SQL, "SELECT * FROM `parks`", "LoadGarkot");
	mysql_tquery(g_SQL, "SELECT * FROM `speedcam`", "LoadSpeedcam");
	mysql_tquery(g_SQL, "SELECT * FROM `actor`", "LoadActor");
	mysql_tquery(g_SQL, "SELECT * FROM `vending`", "LoadVending");	
	mysql_tquery(g_SQL, "SELECT * FROM `callphone`", "LoadCallPhone", "");
	mysql_tquery(g_SQL, "SELECT * FROM `berry`", "LoadBerry");
	mysql_tquery(g_SQL, "SELECT * FROM `trash`", "LoadTrash");
	mysql_tquery(g_SQL, "SELECT * FROM `sigenal`", "LoadSignal");
	mysql_tquery(g_SQL, "SELECT * FROM `slotmachines`", "LoadSlotMachines");
	mysql_tquery(g_SQL, "SELECT * FROM `farm`", "LoadLadang");


	//ShowNameTags(1);
	//nametagsnyar
	ShowNameTags(1);
	EnableTirePopping(0);
	CreateTextDraw();
	CreateServerPoint();
	CreateJoinTaxiPoint();
	CreateJoinGocarPoint();
	CreateJoinMechPoint();
	//CreateJoinMinerPoint();
	CreateJoinProductionPoint();
	CreateJoinTruckPoint();
	CreateJoinMFPoint();
	CreateArmsPoint();
	CreateJoinMarkisaPoint();
	LoadModsPoint();
	//createladangsapi();
    //CreateProgress(playerid);
	//CreateJoinKurirPoint();
	CreateJoinFarmerPoint();
	LoadTazerSAPD();
	CreateJoinSmugglerPoint();
	CreateJoinBaggagePoint();
	//createladangsapi();
	CreateCarStealingPoint();
	CreateJoinPemotongPoint();
	LoadMap();
	LoadArea();
	LoadGym();
	LoadGYMObject();
	PEDMale = LoadModelSelect("pedagangmale.txt");
	PEDFemale = LoadModelSelect("pedagangfemale.txt");
		//model selection
	//vtoylist = LoadModelSelect("vtoylist.txt");
	ResetCarStealing();


	new gm[50];
	format(gm, sizeof(gm), "%s", TEXT_GAMEMODE);
	SetGameModeText(gm);
	format(gm, sizeof(gm), "weburl %s", TEXT_WEBURL);
	SendRconCommand(gm);
	format(gm, sizeof(gm), "language %s", TEXT_LANGUAGE);
	SendRconCommand(gm);
	format(gm, sizeof(gm), "hostname %s", SERVER_NAME);
	SendRconCommand(gm);
	SendRconCommand("mapname San Andreas");
	ManualVehicleEngineAndLights();
	EnableStuntBonusForAll(0);
	AllowInteriorWeapons(1);
	DisableInteriorEnterExits();
	LimitPlayerMarkerRadius(16.0);
	SetNameTagDrawDistance(16.0);
	//DisableNameTagLOS();
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	SetWorldTime(WorldTime);
	SetWeather(WorldWeather);
	BlockGarages(.text="NO ENTER");
	//Audio_SetPack("default_pack");	
	CreateDynamicObject(800, 1754.928588,-187.140090,80.490097, 0.000000, 0.000000, 133.731521, -1, -1, -1, 300.00, 300.00);//Kanabis
	CreateDynamicObject(800, 1754.928588,-187.140090,80.490097, 0.000000, 0.000000, 137.313674, -1, -1, -1, 300.00, 300.00);//Kanabis

	//gzlenz
   	Gzlenz[0] = CreateDynamicSphere(1537.9435,-1675.3668,13.5469, 80.0, 0, 0);
   	Gzlenz[1] = CreateDynamicSphere(1481.1296,-1738.1168,13.5469, 80.0, 0, 0);
   	Gzlenz[2] = CreateDynamicSphere(1189.7944,-1323.8636,13.5669, 80.0, 0, 0);
   	Gzlenz[3] = CreateDynamicSphere(642.7583,-1357.4150,13.5847, 80.0, 0, 0);
   	Gzlenz[4] = CreateDynamicSphere(375.8298,-1812.6981,7.8319, 80.0, 0, 0);

	Healing = CreateDynamicSphere(488.651458,-15.610054,1000.679687, 50.0, 0, 0);

	//green zone map
	/*gzmap[0] = GangZoneCreate(138, -2105, 415, -1786);
	gzmap[1] = GangZoneCreate(1374, -1737.5, 1582, -1556.5);
	gzmap[2] = GangZoneCreate(1083, -2084, 1283, -1991);
	gzmap[3] = GangZoneCreate(624, -1409, 790, -1325);
	gzmap[4] = GangZoneCreate(1135, -1408, 1251, -1277);
	gzmap[5] = GangZoneCreate(2821, -2062, 2911, -1784);
	gzmap[6] = GangZoneCreate(1606, -1957.99609375, 1861, -1829.99609375);
	gzmap[7] = GangZoneCreate(2042, -1947, 2091, -1897);
	gzmap[8] = GangZoneCreate(1376, -1048, 1529, -1011);
	gzmap[9] = GangZoneCreate(828, -634, 894, -526);
	gzmap[10] = GangZoneCreate(-1488, -1596, -1391, -1435);
	gzmap[11] = GangZoneCreate(-95, -1165, 5, -1100);
	gzmap[12] = GangZoneCreate(620, 844, 720, 944);
	gzmap[13] = GangZoneCreate(473, 560, 573, 660);
	gzmap[14] = GangZoneCreate(-323, -2245, -223, -2119);
	gzmap[15] = GangZoneCreate(2061, -2364.6565856933594, 2281, -2189.6565856933594);
	gzmap[16] = GangZoneCreate(1010.2859191894531, -372.000244140625, 1122.2859191894531, -283.000244140625);
	gzmap[17] = GangZoneCreate(1175.2189636230469, 116.32278442382812, 1311.2189636230469, 192.32278442382812);
	gzmap[18] = GangZoneCreate(480.666748046875, 1210, 600.666748046875, 1324);
	gzmap[19] = GangZoneCreate(1672.5, -1544.25390625, 1724.5, -1477.25390625);
	gzmap[20] = GangZoneCreate(2679.23828125, -2561.75, 2858.23828125, -2332.75);
	gzmap[21] = GangZoneCreate(1983.2421875, -1248.0078125, 2064.2421875, -1148.0078125);
	gzmap[22] = GangZoneCreate(2101.8831176757812, -1795.3491516113281, 2131.8831176757812, -1750.3491516113281);
	gzmap[23] = GangZoneCreate(2773.1474609375, -2252.803741455078, 2916.1474609375, -2069.803741455078);
	gzmap[24] = GangZoneCreate(1197.2613220214844, 260.83248138427734, 1359.2613220214844, 414.83248138427734); //black dragon*/


	new strings[1000];
	
	for(new i = 0; i < sizeof(rentVehicle); i ++)
	{
	    CreateDynamicPickup(1239, 23, rentVehicle[i][0], rentVehicle[i][1], rentVehicle[i][2], -1, -1, -1, 50);
		format(strings, sizeof(strings), "[Bike Rental]\n{FFFFFF}/rentbike");
		CreateDynamic3DTextLabel(strings, COLOR_LBLUE, rentVehicle[i][0], rentVehicle[i][1], rentVehicle[i][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // rent bike
	}

	for(new i = 0; i < sizeof(rentBoat); i ++)
	{
	    CreateDynamicPickup(1239, 23, rentBoat[i][0], rentBoat[i][1], rentBoat[i][2], -1, -1, -1, 50);
		format(strings, sizeof(strings), "[Boat Rental]\n{FFFFFF}/rentboat");
		CreateDynamic3DTextLabel(strings, COLOR_LBLUE, rentBoat[i][0], rentBoat[i][1], rentBoat[i][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // rent bike
	}

	for(new i = 0; i < sizeof(unrentVehicle); i ++)
	{
	    CreateDynamicPickup(1239, 23, unrentVehicle[i][0], unrentVehicle[i][1], unrentVehicle[i][2], -1, -1, -1, 50);
		format(strings, sizeof(strings), "[Unrent Vehicle]\n{FFFFFF}/unrentpv\n to unrent your vehicle");
		CreateDynamic3DTextLabel(strings, COLOR_LBLUE, unrentVehicle[i][0], unrentVehicle[i][1], unrentVehicle[i][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // rent bike
	}
	//-----[ Toll System ]-----	
	for(new i;i < sizeof(BarrierInfo);i ++)
	{
		new
		Float:X = BarrierInfo[i][brPos_X],
		Float:Y = BarrierInfo[i][brPos_Y];

		ShiftCords(0, X, Y, BarrierInfo[i][brPos_A]+90.0, 3.5);
		CreateDynamicObject(966,BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z],0.00000000,0.00000000,BarrierInfo[i][brPos_A]);
		if(!BarrierInfo[i][brOpen])
		{
			gBarrier[i] = CreateDynamicObject(968,BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.8,0.00000000,90.00000000,BarrierInfo[i][brPos_A]+180);
			MoveObject(gBarrier[i],BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.7,BARRIER_SPEED,0.0,0.0,BarrierInfo[i][brPos_A]+180);
			MoveObject(gBarrier[i],BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.75,BARRIER_SPEED,0.0,90.0,BarrierInfo[i][brPos_A]+180);
		}
		else gBarrier[i] = CreateDynamicObject(968,BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.8,0.00000000,20.00000000,BarrierInfo[i][brPos_A]+180);
	}

	CreateDynamicPickup(1239, 23, 1392.5812, -12.6790, 1000.9166, -1, -1, -1, 50);
	CreateDynamicCP(1392.5812, -12.6790, 1000.9166, 1.0, -1, -1, -1, 20.0);
	format(strings, sizeof(strings), "Tekan "LG_E"ALT {ffffff}Melihat Layanan Disnaker");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 1392.5812, -12.6790, 1000.9166, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // LAYANAN PEMERINTAH

	CreateDynamicPickup(1239, 23, 1392.5824, -14.8366, 1000.9166, -1, -1, -1, 50);
	CreateDynamicCP(1392.5824,-14.8366,1000.9166, 1.0, -1, -1, -1, 20.0);
	format(strings, sizeof(strings), "Tekan "LG_E"ALT {ffffff} Untuk Membayar Pajak");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 1392.5824,-14.8366,1000.9166, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // LAYANAN PEMERINTAH

	// CreateDynamicPickup(1239, 23, 400.4523, -1803.6069, 7.9219, -1, -1, -1, 50);
	// format(strings, sizeof(strings), "[Dapur]\n{FFFFFF}/menumasak");
	// CreateDynamic3DTextLabel(strings, COLOR_ORANGE2, 400.4523, -1803.6069, 7.9219, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // pencucian uang haram

	CreateDynamicPickup(1239, 23, 1396.8883,-1570.9485,14.2706, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Veh Insurance]\n{FFFFFF}/buyinsu - buy insurance\n/claimpv - claim insurance\n/sellpv - sell vehicle\n/buysparepart - sparepart vehicle");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 1396.8883,-1570.9485,14.2706, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Veh insurance
	
	
	// format(strings, sizeof(strings), "[JOBS BUS]\n{BABABA}Tekan "LG_E" ALT {BABABA}untuk mengakses");
	// CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 1244.857910,-2020.113891,59.894012, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	
	CreateDynamicPickup(1239, 23, 2860.5452,-1877.3788,11.1444, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Tempat Penjualan Pertambangan]\n{BABABA}Tekan "LG_E" ALT {BABABA}untuk mengakses");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 2860.5452,-1877.3788,11.1444, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);

	format(strings, sizeof(strings), "{FFFF00}/sepedagym {FFFFFF}- Memulai Static Bicycle");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 774.7058,-68.6598,1001.9500, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);

	CreateDynamicPickup(1239, 23, 2860.8999,-1858.2836,11.1444, -1, -1, -1, 50);	
    format(strings, sizeof(strings), "[Tempat Penjualan Botol]\n{BABABA}Tekan "LG_E" ALT {BABABA}untuk menjual");
    CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 2860.8999,-1858.2836,11.1444, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);		

	//pedagang//gocar
	Create3DTextLabel("{ffff00}[GOCAR & PEDAGANG VEH]\n{FFFFFF}Use: {ffff00}/takevehgocar {ffffff}Untuk Mengambil\nUse: {ffff00}/inputgocar {ffffff}Untuk Mengembalikan", -1, 340.9970,-1808.8685,4.5301, 10.0, 0, 0);
	CreatePickup(1239, 23, 340.9970,-1808.8685,4.5301, 0);

	CreateDynamicPickup(1239, 23, 333.8837,-1838.2614,4.2963, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Information]\n{FFFFFF}/menu - untuk melihat list menu");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW,333.8837,-1838.2614,4.2963, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Ticket Kota Dilimore

	// CreateDynamicPickup(1239, 23, 2178.0344, 949.2754, 10.8989, -1, -1, -1, 50);
	// format(strings, sizeof(strings), "[Information]\n{FFFFFF}/menu - untuk melihat list menu");
	// CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 2178.0344, 949.2754, 10.8989, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Ticket Kota Dilimore

	CreateDynamicPickup(1239, 23, 287.7309, -105.9845, 1001.5156, -1, -1, -1, 50);
	format(strings, sizeof(strings), "{7fffd4}[Mesin Pengolah]\n{FFFFFF}Use : {ffff00}Otot Y Untuk Mengolah Kanabis\n{FFFFFF}Use: {ffff00}/lockpick Untuk Membuat Lockpick");
	CreateDynamic3DTextLabel(strings, COLOR_GREY, 287.7309, -105.9845, 1001.5156, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //

	CreateDynamicPickup(1239, 23, 887.3530,-20.0613,63.3195, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Kanabis]\n{FFFFFF} Otot Y Untuk mengambil");
	CreateDynamic3DTextLabel(strings, COLOR_GREEN, 887.3530,-20.0613,63.3195, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Ticket Kota Dilimore

	CreateDynamicPickup(1239, 23, 892.5521,-22.5117,63.2470, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Kanabis]\n{FFFFFF} Otot Y Untuk mengambil");
	CreateDynamic3DTextLabel(strings, COLOR_GREEN, 892.5521,-22.5117,63.2470, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Ticket Kota Dilimore

	CreateDynamicPickup(1239, 23, 890.8713,-26.2132,63.2412, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Kanabis]\n{FFFFFF} Otot Y Untuk mengambil");
	CreateDynamic3DTextLabel(strings, COLOR_GREEN, 890.8713,-26.2132,63.2412, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Ticket Kota Dilimore

	CreateDynamicPickup(1239, 23, 885.7568,-23.8099,63.2797, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Kanabis]\n{FFFFFF} Otot Y Untuk mengambil");
	CreateDynamic3DTextLabel(strings, COLOR_GREEN, 885.7568,-23.8099,63.2797, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Ticket Kota Dilimore


	//format(strings, sizeof(strings), "{7fffd4}[Informasi]\n{FFFFFF}Dilarang Membawa Sajam Dan Senjata Api Kedalam..!\nDimohon Taati Peraturan Dari Staff SAGS.\n");
	//CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 1481.3562,-1768.9259,18.8058, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Veh insurance


	//CPMODSHOP
	CreateDynamicPickup(1239, 23, 2316.4182, -2365.8589, 13.5664, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[MODSHOP 1]\n{FFFFFF}/vattach\n");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 2316.4182, -2365.8589, 13.5664, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Veh insurance
	
	CreateDynamicPickup(1239, 23, 2306.6501, -2373.7498, 13.5664, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[MODSHOP 2]\n{FFFFFF}/vattach\n");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 2306.6501, -2373.7498, 13.5664, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Veh insurance

	//pemotong ayam
	format(strings, sizeof(strings), "[AYAM HIDUP]\n{FFFFFF}Gunakan {FFFF00}ALT {FFFFFF}Untuk Ambil Ayam Hidup");
    CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 1023.9856,-295.5638,73.9931, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
    CreateDynamicPickup(1239, 23, 1023.9856,-295.5638,73.9931, -1, -1, -1, 5.0);

	format(strings, sizeof(strings), "[AYAM HIDUP]\n{FFFFFF}Gunakan {FFFF00}ALT {FFFFFF}Untuk Ambil Ayam Hidup");
    CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 1023.9282,-300.4617,73.9931, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
    CreateDynamicPickup(1239, 23, 1023.9282,-300.4617,73.9931, -1, -1, -1, 5.0);
	
	format(strings, sizeof(strings), "[Pemotongan]\n{FFFFFF}Gunakan {FFFF00}ALT {FFFFFF}Untuk Memotong Ayam Hidup");
    CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 1021.0649,-290.3679,77.3594, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
    CreateDynamicPickup(1239, 23, 1021.0649,-290.3679,77.3594, -1, -1, -1, 5.0);

    format(strings, sizeof(strings), "[Packing Ayam]\n{FFFFFF}Gunakan {FFFF00}ALT {FFFFFF}Untuk Membungkus Ayam Potong");
    CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 1021.1126,-307.9776,77.3594, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
    CreateDynamicPickup(1239, 23, 1021.1126,-307.9776,77.3594, -1, -1, -1, 5.0);


	// CreateDynamicPickup(1239, 23, 1294.1837, -1267.9083, 20.6199, -1, -1, -1, 50);
	// format(strings, sizeof(strings), "[Sparepart Shop]\n{FFFFFF}/buysparepart\n");
	// CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 1294.1837, -1267.9083, 20.6199, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Veh insurance
	
	//Penambang batu
	CreateDynamicPickup(1239, 23, 540.4908,593.2016,0.3222, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[CUCI BATU]\n{FFFFFF}Gunakan {FFFF00}ALT {FFFFFF}Untuk Mencuci Batu");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 540.4908,593.2016,0.3222, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Driving Lic

	CreateDynamicPickup(1239, 23, 2152.539062,-2263.646972,13.300081, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[PELEBURAN BATU]\n{FFFFFF}Gunakan {FFFF00}ALT {FFFFFF}Untuk Meleburkan Batu");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 2152.539062,-2263.646972,13.300081, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Driving Lic

	//Batunya
	CreateDynamicPickup(1239, 23, 689.3038,896.0177,-39.3825, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[MINER]\n{FFFFFF}Gunakan {FFFF00}ALT {FFFFFF}Untuk Mengambil Batu");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 689.3038,896.0177,-39.3825, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Driving Lic

	CreateDynamicPickup(1239, 23, 694.6160,897.4399,-39.0123, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[MINER]\n{FFFFFF}Gunakan {FFFF00}ALT {FFFFFF}Untuk Mengambil Batu");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 694.6160,897.4399,-39.0123, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Driving Lic

	CreateDynamicPickup(1239, 23, 699.5721,896.2081,-38.6654, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[MINER]\n{FFFFFF}Gunakan {FFFF00}ALT {FFFFFF}Untuk Mengambil Batu");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 699.5721,896.2081,-38.6654, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Driving Lic

	CreateDynamicPickup(1239, 23, 698.5974,889.7535,-38.6046, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[MINER]\n{FFFFFF}Gunakan {FFFF00}ALT {FFFFFF}Untuk Mengambil Batu");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 698.5974,889.7535,-38.6046, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Driving Lic

	CreateDynamicPickup(1239, 23, 694.7534,885.7076,-38.7663, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[MINER]\n{FFFFFF}Gunakan {FFFF00}ALT {FFFFFF}Untuk Mengambil Batu");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 694.7534,885.7076,-38.7663, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Driving Lic

	CreateDynamicPickup(1239, 23, 689.8557,887.1973,-39.1684, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[MINER]\n{FFFFFF}Gunakan {FFFF00}ALT {FFFFFF}Untuk Mengambil Batu");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 689.8557,887.1973,-39.1684, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Driving Lic

	//Penambang minyak
	CreateDynamicPickup(1239, 23, 562.7084,1317.3960,11.2688, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[OIL DRILLER]\n{FFFFFF}Gunakan {FFFF00}ALT {FFFFFF}Untuk Mengambil Minyak");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 562.7084,1317.3960,11.2688, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Driving Lic

	CreateDynamicPickup(1239, 23, 490.8356,1315.3344,10.0656, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[OIL DRILLER]\n{FFFFFF}Gunakan {FFFF00}ALT {FFFFFF}Untuk Mengambil Minyak");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 490.8356,1315.3344,10.0656, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Driving Lic
				
	CreateDynamicPickup(1239, 23, 570.4109,1219.8687,11.7113, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[OIL DRILLER]\n{FFFFFF}Gunakan {FFFF00}ALT {FFFFFF}Untuk Mengolah Minyak");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 570.4109,1219.8687,11.7113, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Driving Lic
	
	CreateDynamicPickup(1239, 23, 577.0319,1223.9120,11.7113, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[OIL DRILLER]\n{FFFFFF}Gunakan {FFFF00}ALT {FFFFFF}Untuk Mengganti Baju");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 577.0319,1223.9120,11.7113, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Driving Lic
	//	
	CreateDynamicPickup(1239, 23, 2069.7646,-1899.0105,13.5538, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[License]\n{FFFFFF}/renewlic - create new license");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 2069.7646,-1899.0105,13.5538, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Driving Lic
	
	CreateDynamicPickup(1239, 23, 1122.8499,6.6750,883.6204, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Plate]\n{FFFFFF}/buyplate - create new plate");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 1122.8499,6.6750,883.6204, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate Kota LS
	
	CreateDynamicPickup(1239, 23, 1126.1908,6.4489,883.6204, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Ticket]\n{FFFFFF}/payticket - to pay ticket\n{FFFFFF}/unimpound - to unimpound vehicle");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 1126.1908,6.4489,883.6204, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Ticket Kota Ls
	
	CreateDynamicPickup(1239, 23, 1585.3680,-1677.9712,5.8970, -1);
	CreateDynamic3DTextLabel("SAPD Impound Vehicle Point\n/impound", -1, 1585.3680,-1677.9712,5.8970, 10.0);

	//CreateDynamicPickup(1239, 23, 300.7355,1141.1815,9.1375, -1);
	//CreateDynamic3DTextLabel("Ambil pekerjaan pemeras sapi Disini\n{FFFF00}/dutysapi {FFFFFF}- Untuk Mulai bekerja/Stop bekerja", -1, 300.7355,1141.1815,9.1375, 10.0);

	CreateDynamicPickup(1239, 23, 315.1897,1154.7286,8.5859, -1);
	CreateDynamic3DTextLabel("Tekan ALT Untuk mengolah Susu Sapi", -1, 315.1897,1154.7286,8.5859, 10.0);

	CreateDynamicPickup(1239, 23, 1599.4685,-1624.3040,13.4598, -1);
	CreateDynamic3DTextLabel("SAPD Impound Vehicle Spawn\n{FF0000}don't park here!!", -1, 1599.4685,-1624.3040,13.4598, 10.0);

	CreateDynamicPickup(1239, 23, 1111.7695,-60.4549,890.5117, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Arrest Point]\n{FFFF00}/arrest {FFFFFF}- arrest wanted player"); //arrest 1
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 1111.7695,-60.4549,890.5117, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // arrest

	 // SAPD GARAGE 1575.0947, -1678.4772, 27.3889
	CreateDynamicPickup(1289, 23, 1554.1858, -1611.3740, 13.3828, -1);
	format(strings, sizeof(strings), ""LB_E"[SAPD Vehicles]\n"WHITE_E"use '"YELLOW_E"/spawnpd"WHITE_E"' to spawn vehicles\n"WHITE_E"use '"YELLOW_E"/despawnpd"WHITE_E"' to despawn vehicles");
	CreateDynamic3DTextLabel(strings, ARWIN, 1554.1858, -1611.3740, 13.3828, 5.0);

	 // SAMD GARAGE
	CreateDynamicPickup(1239, 23, 1131.5339, -1332.3248, 13.5797, -1);
	format(strings, sizeof(strings), ""LB_E"Samd Vehicles\n"WHITE_E"use '"YELLOW_E"/spawnmd"WHITE_E"' to spawn vehicles\n"WHITE_E"use '"YELLOW_E"/despawnmd"WHITE_E"' to despawn vehicles");
	CreateDynamic3DTextLabel(strings, ARWIN, 1131.5339, -1332.3248, 13.5797, 5.0); // Vehicles Stats Samd
	
	// SAMD DESPAWN HELICOPTER
	CreateDynamicPickup(1239, 23, 1162.8176, -1313.8239, 32.2215, -1);
	format(strings, sizeof(strings), ""LB_E"Samd Vehicles\n"WHITE_E"use '"YELLOW_E"/despawnmd"WHITE_E"' to despawn helicopter medical");
	CreateDynamic3DTextLabel(strings, ARWIN, 1162.8176, -1313.8239, 32.2215, 5.0);

	CreateDynamicPickup(1239, 23, 1480.0067, -1828.6716, 13.5469, -1);
	format(strings, sizeof(strings), ""LB_E"[One Pride SAGS Vehicles]\n"WHITE_E"use '"YELLOW_E"/spawnsags"WHITE_E"' to spawn vehicles\n"WHITE_E"use '"YELLOW_E"/despawnsags"WHITE_E"' to despawn vehicles");
	CreateDynamic3DTextLabel(strings, ARWIN, 1480.0067, -1828.6716, 13.5469, 20.0); // Vehicles Statis Sags
	// SAgs DESPAWN HELICOPTER
	CreateDynamicPickup(1239, 23, 1424.6909, -1789.1492, 33.4297, -1);
	format(strings, sizeof(strings), ""LB_E"[One Pride SAGS Vehicles]\n"WHITE_E"use '"YELLOW_E"/despawnsags"WHITE_E"' to despawn helicopter sags");
	CreateDynamic3DTextLabel(strings, ARWIN, 1424.6909, -1789.1492, 33.4297, 5.0);


	CreateDynamicPickup(1239, 23, 1142.38, -1330.74, 13.62, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Hospital]\n{FFFFFF}/dropinjured");
	CreateDynamic3DTextLabel(strings, COLOR_PINK, 1142.38, -1330.74, 13.62, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // hospital
	
	CreateDynamicPickup(1239, 23, 2309.2776,-2.3124,26.7422, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[BANK]\n{FFFFFF}/newrek - create new rekening");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 2309.2776,-2.3124,26.7422, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // bank

	CreateDynamicPickup(1239, 23, 2309.4172,-8.2714,26.7422, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[BANK]\n{FFFFFF}/bank - access rekening");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 2309.4172,-8.2714,26.7422, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // bank/

	CreateDynamicPickup(1239, 23, 1960.3293, 1364.7899, 8001.0859, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[IKLAN]\n{FFFFFF}/ad - public ads");
	CreateDynamic3DTextLabel(strings, COLOR_ORANGE2, 1960.3293, 1364.7899, 8001.0859, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // iklan

	CreateDynamicPickup(1241, 23, 1352.7783, 1546.4692, 23223.0859, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[MYRICOUS PRODUCTION]\n{FFFFFF}/mix");
	CreateDynamic3DTextLabel(strings, COLOR_ORANGE2, 1352.7783, 1546.4692, 23223.0859, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // racik obat

	CreateDynamicPickup(1239, 23, -427.3773, -392.3799, 16.5802, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Exchange Money]\n{FFFFFF}/washmoney");
	CreateDynamic3DTextLabel(strings, COLOR_ORANGE2, -427.3773, -392.3799, 16.5802, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // pencucian uang haram
	
	CreateDynamicPickup(1239, 23, 2108.7407,-1785.5049,13.3868, -1);
	format(strings, sizeof(strings), "[PIZZA SIDEJOB]\n{FFFFFF}/getpizza\nJadilah Pekerja Pizza Kota One Pride Disini\nGunakan Motor Pizza");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 2108.7407,-1785.5049,13.3868, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //Pizza

	CreateDynamicPickup(1239, 23, -418.5904,-1759.5656,6.2188, -1, -1, -1, 50);
	format(strings, sizeof(strings), "{FF0000}[BARANG ILEGAL]{FFFFFF}\nUse command {FFFF00}/jualbarang\n{FFFFFF}Untuk menjual barang ilegal");
	CreateDynamic3DTextLabel(strings, ARWIN, -418.5904,-1759.5656,6.2188, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Kurir
	
	CreateDynamicPickup(1239, 23, 1956.1532,1364.7899,8001.0859, -1);
	format(strings, sizeof(strings), "[Spray Tags]\n{FFFFFF}/buy");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 1956.1532,1364.7899,8001.0859, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // tags

	CreateDynamicPickup(1275, 23, 375.8044,-2055.2515,8.0156, -1);
	format(strings, sizeof(strings), "[Petani Micin]\n{FFFFFF}Use: {ffff00}/getjobmicin {ffffff}Untuk Mengambil Pekerjaan\nUse: {ffff00}/endjobmicin {ffffff}Untuk Menyelesaikan Pekerjaan");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 375.8044,-2055.2515,8.0156, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //Pizza

	CreateDynamicPickup(1239, 23, 370.1828,-2052.3235,8.0156, -1);
	format(strings, sizeof(strings), "[Pemrosesan Micin]\n{FFFFFF}/prosesmicin");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 370.1828,-2052.3235,8.0156, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // tags

	CreateDynamicPickup(1239, 23, 331.7692,-1838.2615,4.2963, -1);
	format(strings, sizeof(strings), "[Penjualan Micin]\n{FFFFFF}/jualmicin\n/jualsusu - Untuk menjual susu sapi");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 331.7692,-1838.2615,4.2963, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // tags

	CreateDynamicPickup(1239, 23, 1742.8705,-1851.6401,13.4141,  -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Claim Starterpackmu Disini]\n{FFFFFF}/claimsp");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 1742.8705,-1851.6401,13.4141, 50.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // tags

	// CreateDynamicPickup(1239, 23, -2159.04, 640.36, 1052.38,  -1);
	// format(strings, sizeof(strings), "[Job Taxi]\n{FFFFFF}/getjob");
	// CreateDynamic3DTextLabel(strings, COLOR_LBLUE, -2159.04, 640.36, 1052.38, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); 

	CreateDynamicPickup(1239, 23, 2279.5249, -2356.6936, 13.55693,  -1);
	format(strings, sizeof(strings), "[Job Mechanic]\n{FFFFFF}/getjob");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 2279.5249, -2356.6936, 13.55693, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); 

	CreateDynamicPickup(1239, 23, -1448.7006, -1530.6364, 101.7578,  -1);
	format(strings, sizeof(strings), "[Job Lumber]\n{FFFFFF}/getjob");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, -1448.7006, -1530.6364, 101.7578,  3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); 

	CreateDynamicPickup(1239, 23, -77.38, -1136.52, 1.07);
	format(strings, sizeof(strings), "[Job Trucker]\n{FFFFFF}/getjob");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, -77.38, -1136.52, 1.07, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); 

	CreateDynamicPickup(1239, 23, 319.94, 874.77, 20.39,  -1);
	format(strings, sizeof(strings), "[Job Penambang Batu]\n{FFFFFF}/getjob");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 319.94, 874.77, 20.39, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); 

	CreateDynamicPickup(1239, 23, -283.02, -2174.36, 28.66,  -1);
	format(strings, sizeof(strings), "[Job Production]\n{FFFFFF}/getjob");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, -283.02, -2174.36, 28.66, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); 

	CreateDynamicPickup(1239, 23,  -383.67, -1438.90, 26.32,  -1);
	format(strings, sizeof(strings), "[Job Farmer]\n{FFFFFF}/getjob");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE,  -383.67, -1438.90, 26.32, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); 

	CreateDynamicPickup(1239, 23, 988.890563, -1349.136962, 13.5452288,  -1);
	format(strings, sizeof(strings), "[Job Kurir]\n{FFFFFF}/getjob");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 988.890563, -1349.136962, 13.545228, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); 

	CreateDynamicPickup(1239, 23, 977.34, -771.49, 112.20,  -1);
	format(strings, sizeof(strings), "[Job Kurir]\n{FFFFFF}/getjob");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 977.34, -771.49, 112.20, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);  

	CreateDynamicPickup(1239, 23, 2060.2942, -2220.8250, 13.5469,  -1);
	format(strings, sizeof(strings), "[Job Baggae]\n{FFFFFF}/getjob");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 2060.2942, -2220.8250, 13.5469, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); 

	CreateDynamicPickup(1239, 23, 921.77, -1287.54, 14.40,  -1);
	format(strings, sizeof(strings), "[Job Potong Ayam]\n{FFFFFF}/getjob");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 921.77, -1287.54, 14.40, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);

	CreateDynamicPickup(1239, 23, 1227.8773, 181.8018, 20.3798,  -1);
	format(strings, sizeof(strings), "[Job Merchant Filler]\n{FFFFFF}/getjob");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 1227.8773, 181.8018, 20.3798, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); 

	CreateDynamicPickup(2061, 23, 2351.5215, -649.6286, 128.0547, -1);
	format(strings, sizeof(strings), "[Clip Store]\n{FFFFFF}Use: {ffff00}/buyclip");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 2351.5215, -649.6286, 128.0547, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //clip

	// SANA DESPAWN HELICOPTER
	CreateDynamicPickup(1239, 23, 741.9764,-1371.2441,25.8835, -1);
	format(strings, sizeof(strings), ""LB_E"Samd Vehicles\n"WHITE_E"use '"YELLOW_E"/despawnmd"WHITE_E"' to despawn helicopter agency");
	CreateDynamic3DTextLabel(strings, ARWIN, 741.9764,-1371.2441,25.8835, 5.0);

	// SANA GARAGE
	CreateDynamicPickup(1239, 23, 743.5262, -1332.2343, 13.8414, -1);
	format(strings, sizeof(strings), ""LB_E"Sana Vehicles\n"WHITE_E"use '"YELLOW_E"/spawnsana"WHITE_E"' to spawn vehicles\n"WHITE_E"use '"YELLOW_E"/despawnsana"WHITE_E"' to despawn vehicles");
	CreateDynamic3DTextLabel(strings, ARWIN, 743.5262, -1332.2343, 13.8414, 5.0); // Vehicles Stats Sana

	Disnaker = CreateDynamicCP(1392.5812, -8.2285, 1000.9166, 1.0, -1, -1, -1, 20.0);
	CreateDynamicPickup(1239, 23, 1392.5812, -8.2285, 1000.9166, -1, -1, -1, 50);
	CreateDynamic3DTextLabel("{7fff00}Ambil Pekerjaanmu Disini\n{ffffff}Stand Here!", COLOR_LBLUE, 1392.5812, -8.2285, 1000.9166, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1);

	Cafe = CreateDynamicCP(1239.4235,-1327.6514,14.1152, 1.0, -1, -1, -1, 5.0);
	CreateDynamicPickup(1239, 23, 1239.4235,-1327.6514,14.1152, -1, -1, -1, 50);
	CreateDynamic3DTextLabel("{7fff00}Pesan Menu\n{ffffff}Stand Here!", COLOR_LBLUE, 1239.4235,-1327.6514,14.1152, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1);

	SmugglerCP = CreateDynamicCP(973.71, -764.56, 112.34, 1.0, -1, -1, -1, 60.0);
	SAGSLobbyBtn[0] = CreateButton(-2688.83, 808.989, 1501.67, 180.0000);//bank
	SAGSLobbyBtn[1] = CreateButton(-2691.719238, 807.353333, 1501.422241, 0.000000); //bank
	SAGSLobbyBtn[2] = CreateButton(-2067.57, 2692.6, 1501.75, 90.0000);
	SAGSLobbyBtn[3] = CreateButton(-2067.81, 2692.64, 1501.64, -90.0000);
	SAGSLobbyBtn[4] = CreateButton(-2062.34, 2695.24, 1501.72, -90.0000);
	SAGSLobbyBtn[5] = CreateButton(-2062.09, 2695.21, 1501.7, 90.0000);
	SAGSLobbyBtn[6] = CreateButton(-2062.33, 2706.59, 1501.71, -90.0000);
	SAGSLobbyBtn[7] = CreateButton(-2062.08, 2706.69, 1501.73, 90.0000);
	SAGSLobbyDoor[0] = CreateDynamicObject(1569, -2689.33, 807.425, 1499.95, 0.000000, 0.000000, -179.877, -1, -1, -1, 300.00, 300.00);//Bank
	SAGSLobbyDoor[1] = CreateDynamicObject(1569, -2067.72, 2694.67, 1499.96, 0.000000, 0.000000, -89.6241, -1, -1, -1, 300.00, 300.00);
	SAGSLobbyDoor[2] = CreateDynamicObject(1569, -2062.2, 2693.16, 1499.98, 0.000000, 0.000000, 89.9741, -1, -1, -1, 300.00, 300.00);
	SAGSLobbyDoor[3] = CreateDynamicObject(1569, -2062.22, 2704.74, 1499.96, 0.000000, 0.000000, 90.2693, -1, -1, -1, 300.00, 300.00);

	SAMCLobbyBtn[0] = CreateButton(1341.783447, 1553.605834, 23223.714843, 180.0000);
	SAMCLobbyBtn[1] = CreateButton(1343.954101, 1553.465698, 23223.714843, 0.0000);
	SAMCLobbyBtn[2] = CreateButton(1348.173217, 1553.605834, 23223.714843, 180.0000);
	SAMCLobbyBtn[3] = CreateButton(1350.375122, 1553.465698, 23223.714843, 0.0000);
	SAMCLobbyBtn[4] = CreateButton(1354.634765, 1553.605834, 23223.714843, 180.0000);
	SAMCLobbyBtn[5] = CreateButton(1356.775878, 1553.465698, 23223.714843, 0.0000);
	SAMCLobbyDoor[0] = CreateDynamicObject(3089, 1343.584960, 1553.586303, 23223.306640, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SAMCLobbyDoor[1] = CreateDynamicObject(3089, 1350.004760, 1553.586303, 23223.306640, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SAMCLobbyDoor[2] = CreateDynamicObject(3089, 1356.417236, 1553.586303, 23223.306640, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	
	SAPDLobbyBtn[0] = CreateButton(1393.963500, 1102.869140, 23232.085937, 0.0000);
	SAPDLobbyBtn[1] = CreateButton(1405.479248, 1105.198852, 23233.720703, 270.0000);
	SAPDLobbyBtn[2] = CreateButton(1394.418579, 1121.799194, 23233.720703, 0.0000);
	SAPDLobbyBtn[3] = CreateButton(1394.418579, 1121.939331, 23233.720703, 180.0000);
	SAPDLobbyBtn[4] = CreateButton(1393.117919, 1131.710693, 23233.720703, 0.0000);
	SAPDLobbyBtn[5] = CreateButton(1393.117919, 1131.830810, 23233.720703, 180.0000);
	SAPDLobbyDoor[0] = CreateDynamicObject(1569, 1405.392211, 1107.258300, 23232.056640, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SAPDLobbyDoor[1] = CreateDynamicObject(1569, 1392.481933, 1121.837646, 23232.076171, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SAPDLobbyDoor[2] = CreateDynamicObject(1569, 1391.181152, 1131.749633, 23232.076171, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	
	//smuggler
	//objectpacket = CreateDynamicObject(11745, -1304.212036, 2525.925537, 87.532722-1, 0.0, 0.0, 0.0, 0);

	//Discord Embed
	activecs = DCC_FindChannelById("1277660227222769675");
	g_discord_server = DCC_FindChannelById("1186913608903434310");
	//g_discord_server = DCC_FindChannelById("1029619325704863754");
	g_Discord_Serverstatus = DCC_FindChannelById("1186913608903434310");
	g_cekpin = DCC_FindChannelById("1256349533194031104");
	g_Discord_ReportLogs = DCC_FindChannelById("1006286665310027876");
	g_Discord_ReportAccept = DCC_FindChannelById("1006286778006769694");
	g_Discord_Information = DCC_FindChannelById("1243235977175109633");
	merpatiGuild = DCC_FindGuildById("1243213646570459251");
	panelMerpati = DCC_FindChannelById("1243457455791407124");
	//g_discord_logs = DCC_FindChannelById("995360779723358268");
	//-----[ Sidejob Vehicle ]-----	
	AddSweeperVehicle();
	AddBusVehicle();
	AddPizzaVehicle();
	AddStreakVehicle();
	//AddKurirVehicle();
	//sapd static
	CreateDynamicPickup(1239, 23, 1568.40, -1695.66, 5.89, -1);

	AddForVehicle();
	AddMowerVehicle();
	//apartement
    LSApartments1Object = CreateObject(19595, 1160.96, -1180.58, 70.4141, 0, 0, 0);

    // Create the LS Apartments 1 Car Park object
    LSApartments1CPObject = CreateObject(19798, 1160.96, -1180.58, 20.4141, 0, 0, 0);

    // Reset the elevator queue
	ResetElevatorQueue();

	// Create the elevator object, the elevator doors and the floor doors
	Elevator_Initialize();

	// busveh
	//BusVeh[0] = CreateVehicle(431, 1244.857910,-2020.113891,59.894012,180.118698,0,126,120000,0);

	//-----[ Job Vehicle ]-----	
	AddBaggageVehicle();

	//-----[ DMV ]-----	
	AddDmvVehicle();
	DCC_SendChannelMessage(g_Discord_Information, "# SERVER ONLINE 🟢");
	DCC_SetBotNickname(merpatiGuild, "One Pride Roleplay");

	printf("[Objects]: %d Loaded.", CountDynamicObjects());



	for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(!IsPlayerConnected(i)) continue;
        OnPlayerConnect(i);
    }
	//c
	print("                     ____________________________");
	print("                    | 	   PROGRAMED BY SOF. 	 |");
	print("                    | 	   Copyright 2023 (c)	 |");
	print("                     ____________________________");
	return 1;
}


public OnGameModeExit()
{
	new count = 0, count1 = 0;
	foreach(new gsid : GStation)
	{
		if(Iter_Contains(GStation, gsid))
		{
			count++;
			GStation_Save(gsid);
		}
	}
	printf("[Gas Station]: %d Saved.", count);
	
	foreach(new pid : Plants)
	{
		if(Iter_Contains(Plants, pid))
		{
			count1++;
			Plant_Save(pid);
		}
	}
	foreach(new did : Dealer)
	{
		DealerSave(did);
	}

	printf("[Farmer Plants]: %d Saved.", count1);
	for (new i = 0, j = MAX_PLAYERS; i <= j; i++) 
	{
		if (IsPlayerConnected(i))
		{
			OnPlayerDisconnect(i, 1);
		}
	}
	//apartement
        // Check for valid object
	if (IsValidObject(LSApartments1Object))
	{
		// Destroy the LS Apartments 1 Building object
		DestroyObject(LSApartments1Object);
	}

    // Check for valid object
	if (IsValidObject(LSApartments1CPObject))
	{
		// Destroy the LS Apartments 1 Car Park object
		DestroyObject(LSApartments1CPObject);
	}

    // Destroy the elevator, the elevator doors and the elevator floor doors
	Elevator_Destroy();
	UnloadTazerSAPD();
	//Audio_DestroyTCPServer();
	g_Discord_Information = DCC_FindChannelById("1243235977175109633");
	DCC_SendChannelMessage(g_Discord_Information, "# SERVER OFFLINE 🔴");
	DCC_SetBotNickname(merpatiGuild, "Story Of One Pride [MAINTANANCE]");
	mysql_close(g_SQL);
	return 1;
}
public OnFilterScriptInit()
{ 
    return 1;
}

public OnFilterScriptExit()
{
	return 1;
}
/*public OnQueryErrorMsg(errorid, error[], callback[], query[], connectionHandle)
{
	new
	    File:file = fopen("mysql_error.txt", io_append);

	if(file)
	{
	    new
	        string[2048];

		format(string, sizeof(string), "[%s]\r\nError ID: %i\r\nCallback: %s\r\nQuery: %s\r\n[!] %s\r\n\r\n", GetDate(), errorid, callback, query, error);
		fwrite(file, string);
		fclose(file);
	}

	SendStaffMessage(COLOR_RED, "[ERROR MySQL]:{ffffff} MySQL terjadi kesalahan (error %i). Detail ditulis di mysql_error.txt.", errorid);
	return 1;
}*/

//-----[ Button System ]-----	
function SAGSLobbyDoorClose()
{
	MoveDynamicObject(SAGSLobbyDoor[0], -2689.33, 807.425, 1499.95, 3);
	MoveDynamicObject(SAGSLobbyDoor[1], -2067.72, 2694.67, 1499.96, 3);
	MoveDynamicObject(SAGSLobbyDoor[2], -2062.2, 2693.16, 1499.98, 3);
	MoveDynamicObject(SAGSLobbyDoor[3], -2062.22, 2704.74, 1499.96, 3);
	return 1;
}

function SAMCLobbyDoorClose()
{
	MoveDynamicObject(SAMCLobbyDoor[0], 1343.584960, 1553.586303, 23223.306640, 3);
	MoveDynamicObject(SAMCLobbyDoor[1], 1350.004760, 1553.586303, 23223.306640, 3);
	MoveDynamicObject(SAMCLobbyDoor[2], 1356.417236, 1553.586303, 23223.306640, 3);
	return 1;
}

function SAPDLobbyDoorClose()
{
	MoveDynamicObject(SAPDLobbyDoor[0], 1405.392211, 1107.258300, 23232.056640, 3);
	MoveDynamicObject(SAPDLobbyDoor[1], 1392.481933, 1121.837646, 23232.076171, 3);
	MoveDynamicObject(SAPDLobbyDoor[2], 1391.181152, 1131.749633, 23232.076171, 3);
	return 1;
}

public OnPlayerPressButton(playerid, buttonid)
{
	if(buttonid == SAGSLobbyBtn[0] || buttonid == SAGSLobbyBtn[1])
	{
	    if(pData[playerid][pFaction] == 2)
	    {
	        MoveDynamicObject(SAGSLobbyDoor[0], -2687.77, 807.428, 1499.95, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAGSLobbyDoorClose", 5000, 0);
	    }
		else
	    {
	        ErrorMsg(playerid, "Akses ditolak.");
			return 1;
		}
	}
	if(buttonid == SAGSLobbyBtn[2] || buttonid == SAGSLobbyBtn[3])
	{
	    if(pData[playerid][pFaction] == 2)
	    {
	        MoveDynamicObject(SAGSLobbyDoor[1], -2067.73, 2696.24, 1499.96, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAGSLobbyDoorClose", 5000, 0);
	    }
		else
	    {
	        ErrorMsg(playerid, "Akses ditolak.");
			return 1;
		}
	}
	if(buttonid == SAGSLobbyBtn[4] || buttonid == SAGSLobbyBtn[5])
	{
	    if(pData[playerid][pFaction] == 2)
	    {
	        MoveDynamicObject(SAGSLobbyDoor[2], -2062.2, 2691.63, 1499.98, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAGSLobbyDoorClose", 5000, 0);
	    }
		else
	    {
	        ErrorMsg(playerid, "Akses ditolak.");
			return 1;
		}
	}
	if(buttonid == SAGSLobbyBtn[6] || buttonid == SAGSLobbyBtn[7])
	{
	    if(pData[playerid][pFaction] == 2)
	    {
	        MoveDynamicObject(SAGSLobbyDoor[3], -2062.21, 2703.22, 1499.96, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAGSLobbyDoorClose", 5000, 0);
	    }
		else
	    {
	        ErrorMsg(playerid, "Akses ditolak.");
			return 1;
		}
	}
	if(buttonid == SAMCLobbyBtn[0] || buttonid == SAMCLobbyBtn[1])
	{
		if(pData[playerid][pFaction] == 3)
		{
			MoveDynamicObject(SAMCLobbyDoor[0], 1345.074584, 1553.586303, 23223.306640, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAMCLobbyDoorClose", 5000, 0);
		}
		else
	    {
	        ErrorMsg(playerid, "Akses Ditolak Kamu Bukan Fraksi SAMD.");
			return 1;
		}
	}
	if(buttonid == SAMCLobbyBtn[2] || buttonid == SAMCLobbyBtn[3])
	{
		if(pData[playerid][pFaction] == 3)
		{
			MoveDynamicObject(SAMCLobbyDoor[1], 1351.495727, 1553.586303, 23223.306640, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAMCLobbyDoorClose", 5000, 0);
		}
		else
	    {
	        ErrorMsg(playerid, "Akses Ditolak Kamu Bukan Fraksi SAMD.");
			return 1;
		}
	}
	if(buttonid == SAMCLobbyBtn[4] || buttonid == SAMCLobbyBtn[5])
	{
		if(pData[playerid][pFaction] == 3)
		{
			MoveDynamicObject(SAMCLobbyDoor[2], 1357.907714, 1553.586303, 23223.306640, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAMCLobbyDoorClose", 5000, 0);
		}
		else
	    {
	        ErrorMsg(playerid, "Akses Ditolak Kamu Bukan Fraksi SAMD.");
			return 1;
		}
	}
	if(buttonid == SAPDLobbyBtn[0] || buttonid == SAPDLobbyBtn[1])
	{
		if(pData[playerid][pFaction] == 1)
		{
			MoveDynamicObject(SAPDLobbyDoor[0], 1405.392211, 1108.978442, 23232.056640, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAPDLobbyDoorClose", 5000, 0);
		}
		else
	    {
	        ErrorMsg(playerid, "Akses Ditolak Kamu Bukan Fraksi SAPD.");
			return 1;
		}
	}
	if(buttonid == SAPDLobbyBtn[2] || buttonid == SAPDLobbyBtn[3])
	{
		if(pData[playerid][pFaction] == 1)
		{
			MoveDynamicObject(SAPDLobbyDoor[1], 1390.981811, 1121.837646, 23232.076171, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAPDLobbyDoorClose", 5000, 0);
		}
		else
	    {
	        ErrorMsg(playerid, "Akses Ditolak Kamu Bukan Fraksi SAPD.");
			return 1;
		}
	}
	if(buttonid == SAPDLobbyBtn[4] || buttonid == SAPDLobbyBtn[5])
	{
		if(pData[playerid][pFaction] == 1)
		{
			MoveDynamicObject(SAPDLobbyDoor[2], 1389.680786, 1131.749633, 23232.076171, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAPDLobbyDoorClose", 5000, 0);
		}
		else
	    {
	        ErrorMsg(playerid, "Akses Ditolak Kamu Bukan Fraksi SAPD.");
			return 1;
		}
	}
	return 1;
}

IsSAPDCar(carid)
{
	foreach(new i : Player)
	{
		if(carid == pData[i][pFactionVeh]) return 1;
	}
	return 0;
}
IsSAMDCar(carid)
{
	foreach(new i : Player)
	{
		if(carid == pData[i][pSpawnSamd]) return 1;
	}
	return 0;
}
IsGovCar(carid)
{
	foreach(new i : Player)
	{
		if(carid == pData[i][pSpawnSags]) return 1;
	}
	return 0;
}
IsSANACar(carid)
{
	foreach(new i : Player)
	{
		if(carid == pData[i][pSpawnSana]) return 1;
	}
	return 0;
}
IsGOCARCar(carid)
{
	foreach(new i : Player)
	{
		if(carid == pData[i][pSpawnGo]) return 1;
	}
	return 0;
}

stock RemovePlayerFromVehicleEx(playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER && GetPlayerState(playerid) != PLAYER_STATE_PASSENGER) return 0;

	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);

		vehicle_driver[vehicleid] = INVALID_PLAYER_ID;
	}

    new Float: x, Float: y, Float: z;

    GetPlayerPos(playerid, x, y, z);

    return SetPlayerPos(playerid, x + 1.5, y + 1.5, z);
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(ispassenger == 0 && GetVehicleDriver(vehicleid) != INVALID_PLAYER_ID)
	{
		new Float: x, Float: y, Float: z;

		GetPlayerPos(playerid, x, y, z);
		SetPlayerPos(playerid, x, y, z + 2.0);
		PlayerPlaySound(playerid, 1130, 0.0, 0.0, 0.0);
		new String[1280];
		format(String, sizeof String, "~r~DILARANG CJ..!!", GetVehicleName(vehicleid));
		GameTextForPlayer(playerid, String, 4000, 5);
		pData[playerid][pFreeze] = 0;
		TogglePlayerControllable(playerid, 0);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		if(IsPlayerInAnyVehicle(playerid)) 
		{
			RemovePlayerFromVehicle(playerid);
		}
		SetTimerEx("anticjsof", 5000, false, "d", playerid);
	}
	if(!ispassenger)
	{
		if(IsABaggageVeh(vehicleid))
		{
			if(pData[playerid][pJob] != 9 && pData[playerid][pJob2] != 9)
			{
				RemovePlayerFromVehicle(playerid);
				new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
                ErrorMsg(playerid, "Kamu tidak bekerja sebagai Baggage Airport");
				return 1;
			}		
		}
		if(IsADmvVeh(vehicleid))
        {
            if(!pData[playerid][pDriveLicApp])
            {
                RemovePlayerFromVehicle(playerid);
				new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
                ErrorMsg(playerid, "Kamu tidak sedang mengikuti Tes Mengemudi");
			}
			else 
			{
				InfoMsg(playerid, "Silahkan ikuti Checkpoint yang ada di GPS mobil ini.");
				SetPlayerRaceCheckpoint(playerid, 1, dmvpoint1, dmvpoint1, 5.0);
				return 1;
			}
		}
		if(IsSAMDCar(vehicleid))
		{
		if(pData[playerid][pFaction] != 3) // Periksa apakah pemain merupakan anggota faction ID 3 SAMD
			{
				RemovePlayerFromVehicle(playerid); // Hapus pemain dari kendaraan
				new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
				ErrorMsg(playerid, "Hanya anggota SAMD yang dapat menggunakan kendaraan ini!");
				return 1;
			}
		}
		if(IsGovCar(vehicleid))
		{
		if(pData[playerid][pFaction] != 2) // Periksa apakah pemain merupakan anggota faction ID 2 SAFD
			{
				RemovePlayerFromVehicle(playerid); // Hapus pemain dari kendaraan
				new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
				ErrorMsg(playerid, "Hanya anggota SAGS yang dapat menggunakan kendaraan ini!");
				return 1;
			}
		}
		if(IsSANACar(vehicleid))
		{
		if(pData[playerid][pFaction] != 4) // Periksa apakah pemain merupakan anggota faction ID 4 SANA
			{
				RemovePlayerFromVehicle(playerid); // Hapus pemain dari kendaraan
				new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
				ErrorMsg(playerid, "Hanya anggota SANA yang dapat menggunakan kendaraan ini!");
				return 1;
			}
		}
		if(IsSAPDCar(vehicleid))
		{
			if(pData[playerid][pFaction] != 1) // Periksa apakah pemain merupakan anggota faction ID 1 (SAPD)
			{
				RemovePlayerFromVehicle(playerid); // Hapus pemain dari kendaraan
				new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
				ErrorMsg(playerid, "Hanya anggota SAPD yang dapat menggunakan kendaraan ini!");
				return 1;

			}
		}
	}
	return 1;
}


/*GRP::UpgradeBody(playerid, i)
{
	pvData[i][cUpgrade][0] = 1;
	SendServerMessage(playerid, "You've successfully upgraded the body of vehicle!");
	PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
	return 1;
}

GRP::UpgradeEngine(playerid, i)
{
	pvData[i][cUpgrade][1] = 1;
	SendServerMessage(playerid, "You've successfully upgraded the engine of vehicle!");
	SetVehicleMaxHealth(i);
	PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
	return 1;
}

GRP::UpgradeBrake(playerid, i)
{
	pvData[i][cUpgrade][3]++;
	SendServerMessage(playerid, "You've successfully upgraded the brake of vehicle! | Brake level {FF0000}%s", GetUpgradeName(pvData[i][cUpgrade][3]));
	PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
	return 1;
}

GRP::UpgradeTurbo(playerid, i)
{
	pvData[i][cUpgrade][2]++;
	SendServerMessage(playerid, "You've successfully upgraded the turbo of vehicle! | Turbo level {FF0000}%s", GetUpgradeName(pvData[i][cUpgrade][2]));
	PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
	return 1;
}*/
/*stock GetVehicleSpeed(vehicleid)
{
	new Float:speed_x, Float:speed_y, Float:speed_z, Float:temp_speed, round_speed;
	GetVehicleVelocity(vehicleid, speed_x, speed_y, speed_z);

	temp_speed = temp_speed = floatsqroot(((speed_x*speed_x) + (speed_y*speed_y)) + (speed_z*speed_z)) * 136.666667;

	round_speed = floatround(temp_speed);
	return round_speed;
}*/

function showktpforplayer(playerid, userid)
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

    if(userid == INVALID_PLAYER_ID || !NearPlayer(playerid, userid, 5.0))
        return Error(playerid, "Player tidak berada didekat mu.");

    if(userid == playerid)
        return Error(playerid, "Kamu tidak bisa memperlihatkan ID-CARD ke dirimu sendiri.");

    if(pData[playerid][pIDCard] == 0) return ErrorMsg(playerid, "Anda tidak memiliki id card!");

	new strings[560], fac[24], kawin[30];
	if(pData[playerid][pFaction] == 1)
	{
		fac = "One Pride Police";
	}
	else if(pData[playerid][pFaction] == 2)
	{
		fac = "One Pride Goverment";
	}
	else if(pData[playerid][pFaction] == 3)
	{
		fac = "One Pride Medic";
	}
	else if(pData[playerid][pFaction] == 4)
	{
		fac = "One Pride News";
	}
	else if(pData[playerid][pFaction] == 5)
	{
		fac = "One Pride Pedagang";
	}
	else
	{
		fac = "Pengangguran";
	}

	if(pData[playerid][pSudahNikah] == 1)
	{
		kawin = "Sudah Kawin";
	}
	else
	{
		kawin = "Tidak Kawin";
	}

	// Set name player
 	format(strings, sizeof(strings), "%s", pData[playerid][pName]);
 	PlayerTextDrawSetString(userid, IDCard[userid][17], strings);
 	// Set birtdate
 	format(strings, sizeof(strings), "%s", pData[playerid][pAge]);
 	PlayerTextDrawSetString(userid, IDCard[userid][18], strings);
 	// Set Job
 	format(strings, sizeof(strings), "%s", fac);
 	PlayerTextDrawSetString(userid, IDCard[userid][20], strings);
 	// Menikah
 	format(strings, sizeof(strings), "%s", kawin);
 	PlayerTextDrawSetString(userid, IDCard[userid][19], strings);
 	// Set Expired IDCARD
 	format(strings, sizeof(strings), "%s", ReturnTimelapse(gettime(), pData[playerid][pIDCardTime]));
 	PlayerTextDrawSetString(userid, IDCard[userid][12], strings);	

	for(new txd; txd < 26; txd++)
	{
		PlayerTextDrawShow(userid, IDCard[playerid][txd]);
	}
	Info(userid, "/hideidcard Untuk menutup ID CARD");
	Info(playerid, "Anda berhasil memperlihatkan ID-CARD anda ke %s", pData[userid][pName]);
	//SetTimerEx("HIDETDKTP", 5000, false, "i", playerid);
	return 1;
}
function anticjlenz(playerid)
{
	pData[playerid][pFreeze] = 0;
	TogglePlayerControllable(playerid, true);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	Info(playerid, "Visual Kamu Kembali Normal..!!");
}
stock SetVehicleMaxHealth(id)
{
	if(pvData[id][cUpgrade][1] == 1)
	{
	    SetVehicleHealth(pvData[id][cVeh], 2000);
	}
	else
	{
	    SetVehicleHealth(pvData[id][cVeh], 1000);
	}
	return 1;
}

function BotLenz(playerid)
{
    if(!STATUS_BOT2)
    {
		new statuz[256];
		//format(statuz,sizeof(statuz),"!register [nama ucp]");
		//format(statuz,sizeof(statuz),"Players : %d | %dh %02dm One Pride [ONLINE]", pemainic, h, m);
		format(statuz,sizeof(statuz),"%d/%d Players Online", pemainic, GetMaxPlayers());
		DCC_SetBotActivity(statuz);
        STATUS_BOT2 = true;
    }
    else
    {
		new statuz[256];
		new h = 0, m = 0, secs = 0;
		h = floatround(upt / 3600);
		m = floatround((upt / 60) - (h * 60));
		secs = floatround(upt - ((h * 3600) + (m * 60)));
		upt++;
		format(statuz,sizeof(statuz),"Uptime : %02dJ %02dM %02dD", h, m, secs);
		DCC_SetBotActivity(statuz);
        STATUS_BOT2 = false;
    }
    return 1;
}
stock SGetName(playerid)
{
    new name[ 64 ];
    GetPlayerName(playerid, name, sizeof( name ));
    return name;
}

function clearanim(playerid)
{
	ClearAnimations(playerid);
	Info(playerid, "Clear anim berhasil");
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(isnull(text)) return 0;
	new str[150];
	format(str,sizeof(str),"[CHAT] %s: %s", GetRPName(playerid), text);
	LogServer("Chat", str);
	//SendDiscordMessage(2, str);
	//printf(str);
	
	/*if(pData[playerid][pAdminDuty] == 1)
	{
		new lstr[200];
		format(lstr, sizeof(lstr), "{FF0000}%s : {FFFFFF}(( %s ))", ReturnName(playerid), text);
		ProxDetector(25, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
	}*/
	
	if(pData[playerid][pSpawned] == 0 && pData[playerid][IsLoggedIn] == false)
	{
	    ErrorMsg(playerid, "You must be spawned or logged in to use chat.");
	    return 0;
	}
	//-----[ Auto RP ]-----	
	if(!strcmp(text, "rpalat", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Mengambil alat didepan dengan bantuan kedua tangan", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpoperasi", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Mengambil gunting dan bersiap meoprasi pasien didepan dengan kedua tangan", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpsalep", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Memberikan salep kepada pasien didepan dengan kedua tangan", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpperban", true) || !strcmp(text, "memperban", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Mengambil perban dan memberikan kepada pasien didepan dengan kedua tangan", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpgun", true) || !strcmp(text, "gunrp", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s lepaskan senjatanya dari sabuk dan siap untuk menembak kapan saja.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcrash", true) || !strcmp(text, "crashrp", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s kaget setelah kecelakaan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfish", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memancing dengan kedua tangannya.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfall", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s jatuh dan merasakan sakit.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpmad", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s merasa kesal dan ingin mengeluarkan amarah.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rprob", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s menggeledah sesuatu dan siap untuk merampok.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcj", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s mencuri kendaraan seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpwar", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s berperang dengan sesorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpdie", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s pingsan dan tidak sadarkan diri.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfixmeka", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memperbaiki mesin kendaraan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcheckmeka", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memeriksa kondisi kendaraan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfight", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ribut dan memukul seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcry", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s sedang bersedih dan menangis.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rprun", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s berlari dan kabur.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfear", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s merasa ketakutan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpdropgun", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s meletakkan senjata kebawah.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rptakegun", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s mengamnbil senjata.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpgivegun", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memberikan senjata kepada seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpshy", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s merasa malu.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpnusuk", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s menusuk dan membunuh seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpharvest", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memanen tanaman.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpplant", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s menanam bibit di ladang dengan kedua tangan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcut", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memotong pohon dengan bantuan alat chainsaw.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpload", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s membuka trunk dan menaruh potongan kayu di bak mobil.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpunload", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s membuka trunk dan mengambil potongan kayu di bak mobil.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rplockhouse", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s sedang mengunci rumah.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rplockcar", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s sedang mengunci kendaraan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpnodong", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memulai menodong seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpeat", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s makan makanan yang ia beli.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpdrink", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s meminum minuman yang ia beli.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpminer", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memulai memecahkan batu dengan alat shovel.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpblind", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Bersiap menutupi mata orang dikendaraan dengan bantuan kedua tangan", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpunblind", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Melepaskan bandana dengan bantuan kedua tangan", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpdb", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Mengambil senjata kemudian mengeluarkan setengah badan dan siap menembak ", ReturnName(playerid));
		return 0;
	}
	if(text[0] == '@')
	{
		if(pData[playerid][pSMS] != 0)
		{
			if(pData[playerid][pPhoneCredit] < 1)
			{
				ErrorMsg(playerid, "Anda tidak memiliki Credit!");
				return 0;
			}
			if(pData[playerid][pInjured] != 0)
			{
				ErrorMsg(playerid, "Tidak dapat melakukan saat ini.");
				return 0;
			}
			new tmp[512];
			foreach(new ii : Player)
			{
				if(text[1] == ' ')
				{
			 		format(tmp, sizeof(tmp), "%s", text[2]);
				}
				else
				{
				    format(tmp, sizeof(tmp), "%s", text[1]);
				}
				if(pData[ii][pPhone] == pData[playerid][pSMS])
				{
					if(ii == INVALID_PLAYER_ID || !IsPlayerConnected(ii))
					{
						ErrorMsg(playerid, "Nomor ini tidak aktif!");
						return 0;
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "[SMS to %d]"WHITE_E" %s", pData[playerid][pSMS], tmp);
					SendClientMessageEx(ii, COLOR_YELLOW, "[SMS from %d]"WHITE_E" %s", pData[playerid][pPhone], tmp);
					PlayerPlaySound(ii, 6003, 0,0,0);
					pData[ii][pSMS] = pData[playerid][pPhone];
					
					pData[playerid][pPhoneCredit] -= 1;
					return 0;
				}
			}
		}
	}
	if(pData[playerid][pCall] != INVALID_PLAYER_ID)
	{
		// Anti-Caps
		if(GetPVarType(playerid, "Caps"))
			UpperToLower(text);
		new lstr[1024];
		format(lstr, sizeof(lstr), "[CellPhone] %s says: %s", ReturnName(playerid), text);
		ProxDetector(10, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
		SetPlayerChatBubble(playerid, text, COLOR_WHITE, 10.0, 3000);
		SendClientMessageEx(pData[playerid][pCall], COLOR_YELLOW, "[CELLPHONE] "WHITE_E"%s.", text);
		return 0;
	}
	else
	{
		// Anti-Caps
		if(GetPVarType(playerid, "Caps"))
			UpperToLower(text);
		new lstr[1024];
		if(!IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
		{
			if(pData[playerid][pAdminDuty] == 1)
			{
				if(strlen(text) > 64)
				{
					SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s:"WHITE_E" (( %.64s ..", ReturnName(playerid), text);
					SendNearbyMessage(playerid, 20.0, COLOR_WHITE, ".. %s ))", text[64]);
					return 0;
				}
				else
				{
					SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s:"WHITE_E" (( %s ))", ReturnName(playerid), text);
					return 0;
				}
			}

			format(lstr, sizeof(lstr), "%s says: %s", ReturnName(playerid), text);
			ProxDetector(25, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			SetPlayerChatBubble(playerid, text, COLOR_WHITE, 10.0, 3000);
		}
		else if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
		{
			if(pData[playerid][pAdmin] < 1)
			{
				format(lstr, sizeof(lstr), "[OOC ZONE] %s: (( %s ))", ReturnName(playerid), text);
				ProxDetector(40, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			}
			else if(pData[playerid][pAdmin] > 1 || pData[playerid][pHelper] > 1)
			{
				format(lstr, sizeof(lstr), "[OOC ZONE] %s: %s", pData[playerid][pAdminname], text);
				ProxDetector(40, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			}
		}
		return 0;
	}
}
/*public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
    if (result == -1)
    {
        ErrorMsg(playerid, "Unknown Command! Gunakan /help untuk info lanjut.");
        return 0;
    }
	new str[150];
	format(str,sizeof(str),"[CMD] %s: [%s] [%s]", GetRPName(playerid), cmd, params);
	LogServer("Command", str);
	printf(str);
	//SendDiscordMessage(11, str);
    return 1;
}*/


public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
    /*if (result == -1)
    {
        ErrorMsg(playerid, "Command '/%s' tidak dikenali, cobalah '/help' untuk melihat list cmd.", cmd);
        return 0;
    }*/
	new str[1500];
    if (result == -1)
    {
	    format(str,sizeof(str),"Perintah ~y~/%s ~w~Tidak Ditemukan Gunakan ~y~/help", cmd);
		ErrorMsg(playerid, str);
        return 0;
    }

    format(str,sizeof(str),"[CMD] %s: [%s] [%s]", GetRPName(playerid), cmd, params);
    LogServer("Command", str);
    printf(str);
    return 1;
}
public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	return 1;
}

//TD DEATH
stock ShowTdDeath(playerid)
{
	PlayerTextDrawShow(playerid, DeathTD[playerid][0]);
    PlayerTextDrawShow(playerid, DeathTD[playerid][1]);
    PlayerTextDrawShow(playerid, DeathTD[playerid][2]);
    PlayerTextDrawShow(playerid, DeathTD[playerid][3]);
	PlayerTextDrawShow(playerid, DeathTD[playerid][4]);
    PlayerTextDrawShow(playerid, DeathTD[playerid][5]);
    PlayerTextDrawShow(playerid, DeathTD[playerid][6]);
    PlayerTextDrawShow(playerid, DeathTD[playerid][7]);
    return 1;
}
stock HideTdDeath(playerid)
{
	PlayerTextDrawHide(playerid, DeathTD[playerid][0]);
    PlayerTextDrawHide(playerid, DeathTD[playerid][1]);
    PlayerTextDrawHide(playerid, DeathTD[playerid][2]);
    PlayerTextDrawHide(playerid, DeathTD[playerid][3]);
	PlayerTextDrawHide(playerid, DeathTD[playerid][4]);
    PlayerTextDrawHide(playerid, DeathTD[playerid][5]);
    PlayerTextDrawHide(playerid, DeathTD[playerid][6]);
    PlayerTextDrawHide(playerid, DeathTD[playerid][7]);
    return 1;
}

stock HideCafeMenu(playerid)
{
	for(new i = 0; i < 33; i++) {
		TextDrawHideForPlayer(playerid, cafelenz[i]);
	}
	TextDrawHideForPlayer(playerid, burgere);
	TextDrawHideForPlayer(playerid, susune);
	TextDrawHideForPlayer(playerid, kebabe);
	TextDrawHideForPlayer(playerid, nasbunge);
	TextDrawHideForPlayer(playerid, amere);
	TextDrawHideForPlayer(playerid, jeruke);
	TextDrawHideForPlayer(playerid, rokoke);
	TextDrawHideForPlayer(playerid, tutupe);
	TextDrawHideForPlayer(playerid, cakee);
	CancelSelectTextDraw(playerid);
    return 1;
}
stock PlayerFacePlayer( playerid, targetplayerid )
{
	new Float: Angle;
	GetPlayerFacingAngle( playerid, Angle );
	SetPlayerFacingAngle( targetplayerid, Angle+180 );
	return true;
}

function NgeKick(playerid)
{
	Kick(playerid);
	return 1;
}

function AntiChitUcp(playerid)
{
	if(pData[playerid][pTimeChit] > 100)
	{
		SendClientMessage(playerid, COLOR_RED, "Anda terlalu lama di menu Login, Anda telah di Kick Oleh BOT");
		SetTimerEx("NgeKick", 1000, false, "d", playerid);
	}
	return 1;
}

public OnPlayerConnect(playerid)
{	
    //SendClientMessage(playerid, -1, "{56A4E4}[LenzDev.BOT] -> {FFFFFF}Mendeteksi P.");
    SendClientMessage(playerid, -1, "{56A4E4}[Story Of One Pride] -> {FFFFFF}Sedang Memuat Status Akun.");
    SendClientMessage(playerid, -1, "{56A4E4}[BotInfo] -> {FFFFFF}Kamu memiliki waktu 50 Detik untuk Login");
    PakaiSenjata[playerid] = 0;
    PlayerInfo[playerid][pSelectItem] = 0;
    for (new i = 0; i != MAX_INVENTORY; i ++)
	{
	    InventoryData[playerid][i][invExists] = false;
	    InventoryData[playerid][i][invModel] = 0;
	}
	new PlayerIP[16], country[MAX_COUNTRY_LENGTH], city[MAX_CITY_LENGTH], prov[MAX_PROVINCE_LENGTH];
	g_MysqlRaceCheck[playerid]++;
	GetPlayerCountry(playerid, country, MAX_COUNTRY_LENGTH);
	GetPlayerCity(playerid, city, MAX_CITY_LENGTH);
	GetPlayerProvince(playerid, prov, MAX_PROVINCE_LENGTH);
	//nametags
	//cNametag[playerid] = CreateDynamic3DTextLabel("Loading nametag...", 0xFFFFFFFF, 0.0, 0.0, 0.1, NT_DISTANCE, .attachedplayer = playerid, .testlos = 1);
   	//name adminduty
	if(IsValidDynamic3DTextLabel(pData[playerid][AdminTag]))
       DestroyDynamic3DTextLabel(pData[playerid][AdminTag]);

    if(IsValidDynamic3DTextLabel(TagKeluar[playerid]))
  		DestroyDynamic3DTextLabel(TagKeluar[playerid]);

	pemainic++;
	warnings{playerid} = 0;
	AntiBHOP[playerid] = 0;
	IsAtEvent[playerid] = 0;
	takingselfie[playerid] = 0;
	pData[playerid][pDriveLicApp] = 0;
	pData[playerid][pTimeChit]++;
	SetTimerEx("AntiChitUcp", 50000, false, "d", playerid);
	//robrumah
	if(pData[playerid][pTv] == 1)
	{
		SetPlayerAttachedObject(playerid, CRATES, 2318, 1, -0.031, 0.286, 0.000, 0.000, -94.600, 0.000, 1.000,1.000,1.000);
	}
	//mark
	pData[playerid][pMarkTemp] = 0;
	//AntiCheat
	pData[playerid][pJetpack] = 0;
	pData[playerid][pLastUpdate] = 0;
	pData[playerid][pArmorTime] = 0;
	pData[playerid][pACTime] = 0;
	//hapeanyar
	TogglePhone[playerid] = 0;
	ToggleCall[playerid] = 0;
	ToggleSid[playerid] = 0;
	DetikCall[playerid] = 0;
	MenitCall[playerid] = 0;
	JamCall[playerid] = 0;
	//Anim
	pData[playerid][pLoopAnim] = 0;
	// Crates
	CarryCrate[playerid] = 0;
	CarryCrateFish[playerid] = 0;
	CarryCrateCompo[playerid] = 0;
	//melamar
	pData[playerid][pMelamar] = 0;
	//Rob
	pData[playerid][pLastChop] = 0;
	//dron
	SetPVarInt( playerid, "DroneSpawned", 0 );
 	SetPVarFloat( playerid, "OldPosX", 0 );
	SetPVarFloat( playerid, "OldPosY", 0 );
	SetPVarFloat( playerid, "OldPosZ", 0 );
	//Pengganti IsValidTimer
	pData[playerid][pProductingStatus] = 0;
	pData[playerid][pCookingStatus] = 0;
	pData[playerid][pMechanicStatus] = 0;
	pData[playerid][pActivityStatus] = 0;
	pData[playerid][pArmsDealerStatus] = 0;
	pData[playerid][pForklifterLoadStatus] = 0;
	pData[playerid][pForklifterUnLoadStatus] = 0;
	pData[playerid][pFillStatus] = 0;
	pData[playerid][pGetMarkisa] = 0;
	pData[playerid][pGetMarkisaStatus] = 0;
	pData[playerid][pGetChicken1] = 0;
	pData[playerid][pFryChicken1] = 0;
	pData[playerid][pPackingChicken1] = 0;
	pData[playerid][pProsesMicin] = 0;
	pData[playerid][pProgress] = 0;
	KillTimer(TimerLoading[playerid]);
	LoadingPlayerBar[playerid] = 0;
	//pData[playerid][pProgress] = 0;


	/*if(IsPlayerHaveAutoaim(playerid))
    {
        GameTextForPlayer(playerid, "~w~TURN OFF AUTO AIM!", 5000, 5);
        SetTimerEx("KickBro", 500, false, "i", playerid);
    }*/

	ResetVariables(playerid);
	RemoveMappingGreenland(playerid);
	CreatePlayerTextDraws(playerid);
	XinonHUDTextdraw(playerid);
	CreatePlayerInv(playerid);
    CreateProgress(playerid);
	CreatePlayerSlot(playerid);
	/*LagiKerja[playerid] = false;
	Kurir[playerid] = false;
	angkatBox[playerid] = false;*/
	shotTime[playerid] = 0;
    shot[playerid] = 0;
	//SetPlayerMapIcon(playerid, 12, 1001.29,-1356.507,12.992, 51 , 0, MAPICON_LOCAL); // ICON TRUCKER
	//TextDrawShowForPlayer(playerid, Logotd1);
	//TextDrawShowForPlayer(playerid, Logotd2);
	GetPlayerName(playerid, pData[playerid][pUCP], MAX_PLAYER_NAME);
	GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
	pData[playerid][pIP] = PlayerIP;
	pData[playerid][pID] = playerid;
	InterpolateCameraPos(playerid, 365.1590, -2068.9426, 44.7285, 657.4482, -1494.5645, 47.0538, 50000);
	InterpolateCameraLookAt(playerid, 247.605590, -1841.989990, 39.802570, 817.645996, -1645.395751, 29.292520, 15000);

	//dualucp
	if(!IsNameUsed(playerid, GetName(playerid))) 
    {
        SetTimerEx("SafeLogin", 1000, 0, "i", playerid);
        //Prose Load Data
        new query[103];
        mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `playerucp` WHERE `ucp` = '%e' LIMIT 1", pData[playerid][pUCP]);
        mysql_pquery(g_SQL, query, "OnPlayerDataLoaded", "dd", playerid, g_MysqlRaceCheck[playerid]);
        SetPlayerColor(playerid, COLOR_WHITE);

        pData[playerid][activitybar] = CreatePlayerProgressBar(playerid, 273.500000, 157.333541, 88.000000, 8.000000, 5930683, 100, 0);
        //hbe
		pData[playerid][heathbar] = CreatePlayerProgressBar(playerid, 488.000000, 361.000000, 62.000000, 5.000000, -16776961, 100.0, 0);
		pData[playerid][armorbar] = CreatePlayerProgressBar(playerid, 488.000000, 373.000000, 62.000000, 5.000000, -1061109505, 100.0, 0);
					
		pData[playerid][hungrybar] = CreatePlayerProgressBar(playerid, 488.000000, 394.000000, 62.000000, 5.000000, 16711935, 100.0, 0);
		pData[playerid][energybar] = CreatePlayerProgressBar(playerid, 488.000000, 407.000000, 62.000000, 5.000000, 16711935, 100.0, 0);
		pData[playerid][bladdybar] = CreatePlayerProgressBar(playerid, 488.000000, 422.000000, 62.000000, 5.000000, 16711935, 100.0, 0);
	

        //ShotsTD

        pData[playerid][pInjuredLabel] = CreateDynamic3DTextLabel("", COLOR_ORANGE, 0.0, 0.0, -0.3, 10, .attachedplayer = playerid, .testlos = 1);

        if(pData[playerid][pHead] < 0) return pData[playerid][pHead] = 20;

        if(pData[playerid][pPerut] < 0) return pData[playerid][pPerut] = 20;

        if(pData[playerid][pRFoot] < 0) return pData[playerid][pRFoot] = 20;

        if(pData[playerid][pLFoot] < 0) return pData[playerid][pLFoot] = 20;

        if(pData[playerid][pLHand] < 0) return pData[playerid][pLHand] = 20;
    
        if(pData[playerid][pRHand] < 0) return pData[playerid][pRHand] = 20;
        //PlayAudioStreamForPlayer(playerid, "http://www.soi-rp.com/music/songs/LP-A_Light.mp3");  
	}   
    else    
    {
        Info(playerid, "{ff0000}One Pride Protect : Hanya Bisa Login Dengan 1 Perangkat Cuy..!");
        KickEx(playerid);
	}   
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	pemainic--;
	PlayerLeaveSlots(playerid);
	Player_ResetDamageLog(playerid);
	//spawn1jam
	pData[playerid][pDelaySpawn] = gettime() + 3600;
	//SetPlayerName(playerid, pData[playerid][pUCP]);
	warnings{playerid} = 0;
    if(pData[playerid][pJob] == 1)
	{
	    mekanik--;
	}
	else if(pData[playerid][pJob] == 10)
	{
    	tukangayam--;
	}
	else if(pData[playerid][pJob] == 2)
	{
    	tukangtebang--;
	}
	else if(pData[playerid][pJob] == 13)
	{
	    DeleteMinyakCP(playerid);
    	penambangminyak--;
	}
	else if(pData[playerid][pJob] == 4)
	{
    	penambang--;
    	DeletePenambangCP(playerid);
	}
	else if(pData[playerid][pJob] == 12)
	{
    	markisaa--;
	}
	else if(pData[playerid][pJob] == 9)
	{
    	bagage--;
	}
	else if(pData[playerid][pJob] == 6)
	{
    	petani--;
	}
	else if(pData[playerid][pJob] == 3)
	{
    	Trucker--;
	}
	else if(pData[playerid][pJob] == 5)
	{
    	product--;
	}
	// else if(pData[playerid][pJob] == 1)
	// {
    // 	Sopirbus--;
	// }
	else if(pData[playerid][pJob] == 11)
	{
    	Merchantfiller--;
	}
	else if(pData[playerid][pJob] == 14)
	{
    	Taxi--;
	}
	else if(pData[playerid][pJob] == 15)
	{
    	PekerjaSapi--;
	}
    // if(IsValidVehicle(BusVeh[0]))
	// DestroyVehicle(BusVeh[0]);  //jika player disconnect maka bus akan ilang


	//Pengganti IsValidTimer
	PlayerTent[playerid] = 0;
	pData[playerid][pOnline] = 0;
	pData[playerid][pProductingStatus] = 0;
	pData[playerid][pCookingStatus] = 0;
	pData[playerid][pMechanicStatus] = 0;
	pData[playerid][pActivityStatus] = 0;
	pData[playerid][pArmsDealerStatus] = 0;
	pData[playerid][pForklifterLoadStatus] = 0;
	pData[playerid][pForklifterUnLoadStatus] = 0;
	pData[playerid][pFillStatus] = 0;
	pData[playerid][pGetMarkisa] = 0;
	pData[playerid][pProsesMarkisa] = 0;
	pData[playerid][pGetChicken1] = 0;
	pData[playerid][pFryChicken1] = 0;
	pData[playerid][pPackingChicken1] = 0;
	pData[playerid][pProsesMicin] = 0;
	pData[playerid][pProgress] = 0;
	KillTimer(TimerLoading[playerid]);
	LoadingPlayerBar[playerid] = 0;
	pData[playerid][pDragged] = 0;
    pData[playerid][pDraggedBy] = INVALID_PLAYER_ID;
    pData[playerid][pMaskOn] = 0;
    //KillTimer(pData[playerid][pMilkJob]);
    //KillTimer(pData[playerid][pOlahMilk]);

	
	
	
	//spawn
	pData[playerid][pSpawnList] = 0;
	//hapeanyar
	TogglePhone[playerid] = 0;
	ToggleSid[playerid] = 0;
	ToggleCall[playerid] = 0;
	DetikCall[playerid] = 0;
	MenitCall[playerid] = 0;
	JamCall[playerid] = 0;
	if(IsValidDynamic3DTextLabel(pData[playerid][pMaskLabel]))
       DestroyDynamic3DTextLabel(pData[playerid][pMaskLabel]);
    // if(IsValidDynamic3DTextLabel(pData[playerid][pMaskLabel]))
       //DestroyDynamic3DTextLabel(pData[playerid][pMaskLabel]);

	DestroyDynamic3DTextLabel(pData[playerid][pInjuredLabel]);
	/*LagiKerja[playerid] = false;
	Kurir[playerid] = false;*/
	//dron
	DestroyVehicle( Drones[playerid] );
	Drones[playerid] = INVALID_VEHICLE_ID;

	DestroyVehicle(pData[playerid][pTrailer]);
	pData[playerid][pTrailer] = INVALID_VEHICLE_ID;
	

	//nametags
    //if(IsValidDynamic3DTextLabel(cNametag[playerid]))
             // DestroyDynamic3DTextLabel(cNametag[playerid]);

	pData[playerid][pDriveLicApp] = 0;
	takingselfie[playerid] = 0;

	pData[playerid][pTogMusic] = false;

	if(IsPlayerInAnyVehicle(playerid))
	{
        RemovePlayerFromVehicle(playerid);
    }
	
	for(new i; i <= 9; i++)
	{
		if(MyBaggage[playerid][i] == true)
		{
		    MyBaggage[playerid][i] = false;
		    DialogBaggage[i] = false;
			if(IsValidVehicle(pData[playerid][pTrailerBaggage]))
		    	DestroyVehicle(pData[playerid][pTrailerBaggage]);
			pData[playerid][pTrailerBaggage] = INVALID_VEHICLE_ID;  //jika player disconnect maka trailer akan kembali seperti awal
		}
    }
	//boombox
	if(GetPVarType(playerid, "PlacedBB"))
    {
        DestroyDynamicObject(GetPVarInt(playerid, "PlacedBB"));
        DestroyDynamic3DTextLabel(STREAMER_TAG_3D_TEXT_LABEL:GetPVarInt(playerid, "BBLabel"));
        if(GetPVarType(playerid, "BBArea"))
        {
            foreach(new i : Player)
            {
                if(IsPlayerInDynamicArea(i, GetPVarInt(playerid, "BBArea")))
                {
                    StopAudioStreamForPlayer(i);
                    SendClientMessage(i, COLOR_PURPLE, " The boombox creator has disconnected from the server.");
                }
            }
        }
    }
	//UpdateWeapons(playerid);
	g_MysqlRaceCheck[playerid]++;
	
	if(pData[playerid][IsLoggedIn] == true)
	{
		if(IsAtEvent[playerid] == 0)
		{
			UpdatePlayerData(playerid);
		}
		RemovePlayerVehicle(playerid);
		Report_Clear(playerid);
		Ask_Clear(playerid);
		//Player_ResetMining(playerid);
		Player_ResetCutting(playerid);
		Player_RemoveLumber(playerid);
		Player_ResetHarvest(playerid);
		KillTazerTimer(playerid);
		if(IsValidVehicle(pData[playerid][pTrailer]))
			DestroyVehicle(pData[playerid][pTrailer]);
		pData[playerid][pTrailer] = INVALID_VEHICLE_ID;

		pData[playerid][pTrailer] = INVALID_VEHICLE_ID;
		if(IsAtEvent[playerid] == 1)
		{
			if(GetPlayerTeam(playerid) == 1)
			{
				if(EventStarted == 1)
				{
					RedTeam -= 1;
					foreach(new ii : Player)
					{
						if(GetPlayerTeam(ii) == 2)
						{
							GivePlayerMoneyEx(ii, EventPrize);
							Servers(ii, "Selamat, Tim Anda berhasil memenangkan Event dan Mendapatkan Hadiah $%d per orang", EventPrize);
							SetPlayerPos(ii, pData[ii][pPosX], pData[ii][pPosY], pData[ii][pPosZ]);
							pData[playerid][pHospital] = 0;
							ClearAnimations(ii);
							BlueTeam = 0;
						}
						else if(GetPlayerTeam(ii) == 1)
						{
							Servers(ii, "Maaf, Tim anda sudah terkalahkan, Harap Coba Lagi lain waktu");
							SetPlayerPos(ii, pData[ii][pPosX], pData[ii][pPosY], pData[ii][pPosZ]);
							pData[playerid][pHospital] = 0;
							ClearAnimations(ii);
							RedTeam = 0;
						}
					}
				}
			}
			if(GetPlayerTeam(playerid) == 2)
			{
				if(EventStarted == 1)
				{
					BlueTeam -= 1;
					foreach(new ii : Player)
					{
						if(GetPlayerTeam(ii) == 1)
						{
							GivePlayerMoneyEx(ii, EventPrize);
							Servers(ii, "Selamat, Tim Anda berhasil memenangkan Event dan Mendapatkan Hadiah $%d per orang", EventPrize);
							SetPlayerPos(ii, pData[ii][pPosX], pData[ii][pPosY], pData[ii][pPosZ]);
							pData[playerid][pHospital] = 0;
							ClearAnimations(ii);
							BlueTeam = 0;
						}
						else if(GetPlayerTeam(ii) == 2)
						{
							Servers(ii, "Maaf, Tim anda sudah terkalahkan, Harap Coba Lagi lain waktu");
							SetPlayerPos(ii, pData[ii][pPosX], pData[ii][pPosY], pData[ii][pPosZ]);
							pData[playerid][pHospital] = 0;
							ClearAnimations(ii);
							BlueTeam = 0;
						}
					}
				}
			}
			SetPlayerTeam(playerid, 0);
			IsAtEvent[playerid] = 0;
			pData[playerid][pInjured] = 0;
			pData[playerid][pSpawned] = 1;
			UpdateDynamic3DTextLabelText(pData[playerid][pInjuredLabel], COLOR_ORANGE, "");
		}
		if(GetPVarType(playerid, "pTenda"))
		{
			DestroyDynamicObject(GetPVarInt(playerid, "pTenda"));
			DestroyDynamic3DTextLabel(Text3D:GetPVarInt(playerid, "pTentLabel"));
			if(GetPVarType(playerid, "pTentArea"))
			{
				new string[128];
				format(string, sizeof(string), "Tent Owner (%s) Has Left The Game", GetPlayerNameEx(playerid));
				foreach(new i : Player)
				{
					if(IsPlayerInDynamicArea(i, GetPVarInt(playerid, "pTentArea")))
					{
						SendClientMessage(i, COLOR_PURPLE, string);
					}
				}
			}
		}
		if(pData[playerid][pRobLeader] == 1)
		{
			foreach(new ii : Player) 
			{
				if(pData[ii][pMemberRob] > 1)
				{
					Servers(ii, "* Pemimpin Perampokan anda telah keluar! [ MISI GAGAL ]");
					pData[ii][pMemberRob] = 0;
					RobMember = 0;
					pData[ii][pRobLeader] = 0;
					ServerMoney += robmoney;
				}
			}
		}
		if(pData[playerid][pMemberRob] == 1)
		{
			pData[playerid][pMemberRob] = 0;
			foreach(new ii : Player) 
			{
				if(pData[ii][pRobLeader] > 1)
				{
					Servers(ii, "* Member berkurang 1");
					pData[ii][pMemberRob] -= 1;
					RobMember -= 1;
				}
			}
		}
	}
	
	if(IsValidDynamic3DTextLabel(pData[playerid][pAdoTag]))
        DestroyDynamic3DTextLabel(pData[playerid][pAdoTag]);

    if(IsValidDynamic3DTextLabel(pData[playerid][pBTag]))
            DestroyDynamic3DTextLabel(pData[playerid][pBTag]);
			
	if(IsValidDynamicObject(pData[playerid][pFlare]))
            DestroyDynamicObject(pData[playerid][pFlare]);

    pData[playerid][pAdoActive] = false;
	
	/*if(cache_is_valid(pData[playerid][Cache_ID]) && pData[playerid][IsLoggedIn] == false)
	{
		cache_delete(pData[playerid][Cache_ID]);
		pData[playerid][Cache_ID] = MYSQL_INVALID_CACHE;
	}*/

	if (pData[playerid][LoginTimer])
	{
		KillTimer(pData[playerid][LoginTimer]);
		pData[playerid][LoginTimer] = 0;
	}

	pData[playerid][IsLoggedIn] = false;
	
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	
	/*foreach(new ii : Player)
	{
		if(IsPlayerInRangeOfPoint(ii, 40.0, x, y, z))
		{
			switch(reason)
			{
				case 0:
				{
					SendClientMessageEx(ii, COLOR_RED, "[SERVER]:{ffffff} %s disconnected from the server One Pride.{7fffd4}(FC/Crash/Timeout)", pData[playerid][pName]);
				}
				case 1:
				{
					SendClientMessageEx(ii, COLOR_RED, "[SERVER]:{ffffff} %s disconnected from the server One Prideand.{7fffd4}(Disconnected)", pData[playerid][pName]);
				}
				case 2:
				{
					SendClientMessageEx(ii, COLOR_RED, "[SERVER]:{ffffff} %s disconnected from the server One Pride.{7fffd4}(Kick/Banned)", pData[playerid][pName]);
				}
			}
		}
	}*/
	new string[1280];
	new strings[1280];
	new reasontext[526];
	switch(reason)
	{
	    case 0: reasontext = "Timeout/ Crash";
	    case 1: reasontext = "Quit";
	    case 2: reasontext = "Kicked/ Banned";
	}
	/*foreach(new ii : Player)
	{
		if(IsPlayerInRangeOfPoint(ii, 40.0, x, y, z))
		{
			switch(reason)
			{
				case 0:
				{
					SendClientMessageEx(ii, COLOR_RED, "<!> One of the players near you has left the server");
				}
			}
		}
	}*/
	//NAMETAGSNYAR
	format(strings, sizeof(strings), "[%s | %s (%d) Telah Keluar Dari Kota\nAlasan: [%s]", pData[playerid][pName], pData[playerid][pUCP], playerid, reasontext);
	TagKeluar[playerid] = CreateDynamic3DTextLabel(strings, 0xC6E2FFFF, x, y, z, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Text Jika Player Disconnect
 	SetTimerEx("WaktuKeluar", 25000, false, "d", playerid);

	Delete3DTextLabel(LenzSangar[playerid]);

	new name[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, name, sizeof name);
    format(string, sizeof string, "ID %d", playerid);
    new str[5260],stra[5260],stro[5260];
    format(string, sizeof string, "Player ID %d",playerid);
    new DCC_Embed:dc;
 	format(str,sizeof(str),"%s",name);
 	format(stra,sizeof(stra),"%s",reasontext);
 	format(stro,sizeof(stro),"%d/%d", pemainic, GetMaxPlayers());
	dc = DCC_CreateEmbed("One Pride ROLEPLAY","Player Disconnect","","",0xff0000,"Join us discord.io/One Priderp","","","");
	DCC_AddEmbedField(dc, str, string, true);
	DCC_AddEmbedField(dc, "Reason", stra, true);
	DCC_AddEmbedField(dc, "Current Player", stro, true);
	DCC_SendChannelEmbedMessage(g_discord_server, dc);


	return 1;
}

Ndeliknetw(playerid)
{
	foreach(new ii : Player)
	{
		PlayerTextDrawHide(ii, LenzTW2[playerid][0]);
		PlayerTextDrawHide(ii, LenzTW2[playerid][1]);
		PlayerTextDrawHide(ii, LenzTW2[playerid][2]);
		PlayerTextDrawHide(ii, LenzTW2[playerid][3]);
		PlayerTextDrawHide(ii, LenzTW2[playerid][4]);
		PlayerTextDrawHide(ii, LenzTW2[playerid][5]);
		PlayerTextDrawHide(ii, LenzTW2[playerid][6]);
		PlayerTextDrawHide(ii, LenzTW2[playerid][7]);
		PlayerTextDrawHide(ii, LenzTW2[playerid][8]);
	}
	return 1;
}

forward Lenzganteng(playerid);
public Lenzganteng(playerid)
{
	Ndeliknetw(playerid);
    return 1;
}
function ClosePlayerRadialTRY(playerid)
{
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][0]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][1]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][2]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][3]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][4]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][5]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][6]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][7]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][8]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][9]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][10]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][11]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][12]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][13]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][14]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][15]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][16]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][17]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][18]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][19]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][20]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][21]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][22]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][23]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][24]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][25]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][26]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][27]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][28]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][29]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][30]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][31]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][32]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][33]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][34]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][35]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][36]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][37]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][38]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][39]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][40]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][41]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][42]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][43]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][44]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][45]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][46]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][47]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][48]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][49]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][50]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][51]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][52]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][53]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][54]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][55]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][56]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][57]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][58]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][59]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][60]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][61]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][62]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][63]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][64]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][65]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][66]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][67]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][68]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][69]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][70]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][71]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][72]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][73]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][74]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][75]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][76]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][77]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][78]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][79]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][80]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][81]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][82]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][83]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][84]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][85]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][86]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][87]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][88]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][89]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][90]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][91]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][92]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][93]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][94]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][95]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][96]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][97]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][98]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][99]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][100]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][101]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][102]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][103]);
	PlayerTextDrawHide(playerid, C_Car[playerid]);
	PlayerTextDrawHide(playerid, C_Inv[playerid]);
	PlayerTextDrawHide(playerid, C_hp[playerid]);
	PlayerTextDrawHide(playerid, C_dokumen[playerid]);
	PlayerTextDrawHide(playerid, C_aksi[playerid]);
	PlayerTextDrawHide(playerid, C_Aksesoris[playerid]);
	PlayerTextDrawHide(playerid, C_ClosePanel[playerid]);
	CancelSelectTextDraw(playerid);
}

function HideHpLenz(playerid)
{
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][0]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][1]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][2]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][3]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][4]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][5]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][6]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][7]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][8]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][9]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][10]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][11]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][12]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][13]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][14]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][15]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][16]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][17]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][18]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][19]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][20]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][21]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][22]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][23]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][24]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][25]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][26]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][27]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][28]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][29]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][30]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][31]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][32]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][33]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][34]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][35]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][36]);
	PlayerTextDrawHide(playerid, adshplenz[playerid]);
	PlayerTextDrawHide(playerid, airdrophplenz[playerid]);
	PlayerTextDrawHide(playerid, contacthplenz[playerid]);
	PlayerTextDrawHide(playerid, camerahplenz[playerid]);
	PlayerTextDrawHide(playerid, callhplenz[playerid]);
	PlayerTextDrawHide(playerid, jobhplenz[playerid]);
	PlayerTextDrawHide(playerid, musichplenz[playerid]);
	PlayerTextDrawHide(playerid, gojekhplenz[playerid]);
	PlayerTextDrawHide(playerid, bankhplenz[playerid]);
	PlayerTextDrawHide(playerid, mapshplenz[playerid]);
	PlayerTextDrawHide(playerid, twhplenz[playerid]);
	PlayerTextDrawHide(playerid, settinghplenz[playerid]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][37]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][38]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][39]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][40]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][41]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][42]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][43]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][44]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][45]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][46]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][47]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][48]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][49]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][50]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][51]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][52]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][53]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][54]);
	PlayerTextDrawHide(playerid, hplenzbaru[playerid][55]);
	PlayerTextDrawHide(playerid, closehplenz[playerid]);
	return 1;
}
function ClosePlayerRadialTry(playerid)
{
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][0]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][1]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][2]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][3]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][4]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][5]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][6]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][7]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][8]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][9]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][10]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][11]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][12]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][13]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][14]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][15]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][16]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][17]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][18]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][19]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][20]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][21]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][22]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][23]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][24]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][25]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][26]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][27]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][28]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][29]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][30]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][31]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][32]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][33]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][34]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][35]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][36]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][37]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][38]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][39]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][40]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][41]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][42]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][43]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][44]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][45]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][46]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][47]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][48]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][49]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][50]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][51]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][52]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][53]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][54]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][55]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][56]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][57]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][58]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][59]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][60]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][61]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][62]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][63]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][64]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][65]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][66]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][67]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][68]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][69]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][70]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][71]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][72]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][73]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][74]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][75]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][76]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][77]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][78]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][79]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][80]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][81]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][82]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][83]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][84]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][85]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][86]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][87]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][88]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][89]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][90]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][91]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][92]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][93]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][94]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][95]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][96]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][97]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][98]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][99]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][100]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][101]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][102]);
	PlayerTextDrawHide(playerid, TRYRADIAL[playerid][103]);
	PlayerTextDrawHide(playerid, C_Car[playerid]);
	PlayerTextDrawHide(playerid, C_Inv[playerid]);
	PlayerTextDrawHide(playerid, C_hp[playerid]);
	PlayerTextDrawHide(playerid, C_dokumen[playerid]);
	PlayerTextDrawHide(playerid, C_aksi[playerid]);
	PlayerTextDrawHide(playerid, C_Aksesoris[playerid]);
	PlayerTextDrawHide(playerid, C_ClosePanel[playerid]);
	CancelSelectTextDraw(playerid);
}
function ShowHpLenz(playerid)
{
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][0]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][1]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][2]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][3]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][4]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][5]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][6]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][7]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][8]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][9]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][10]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][11]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][12]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][13]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][14]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][15]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][16]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][17]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][18]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][19]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][20]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][21]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][22]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][23]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][24]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][25]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][26]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][27]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][28]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][29]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][30]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][31]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][32]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][33]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][34]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][35]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][36]);
	PlayerTextDrawShow(playerid, adshplenz[playerid]);
	PlayerTextDrawShow(playerid, airdrophplenz[playerid]);
	PlayerTextDrawShow(playerid, contacthplenz[playerid]);
	PlayerTextDrawShow(playerid, camerahplenz[playerid]);
	PlayerTextDrawShow(playerid, callhplenz[playerid]);
	PlayerTextDrawShow(playerid, jobhplenz[playerid]);
	PlayerTextDrawShow(playerid, musichplenz[playerid]);
	PlayerTextDrawShow(playerid, gojekhplenz[playerid]);
	PlayerTextDrawShow(playerid, bankhplenz[playerid]);
	PlayerTextDrawShow(playerid, mapshplenz[playerid]);
	PlayerTextDrawShow(playerid, twhplenz[playerid]);
	PlayerTextDrawShow(playerid, settinghplenz[playerid]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][37]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][38]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][39]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][40]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][41]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][42]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][43]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][44]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][45]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][46]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][47]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][48]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][49]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][50]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][51]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][52]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][53]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][54]);
	PlayerTextDrawShow(playerid, hplenzbaru[playerid][55]);
	PlayerTextDrawShow(playerid, closehplenz[playerid]);
}
function ShowPanelLenz(playerid)
{
	PlayerTextDrawShow(playerid, vpanellenz[playerid][0]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][1]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][2]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][3]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][4]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][5]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][6]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][7]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][8]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][9]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][10]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][11]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][12]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][13]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][14]);
	PlayerTextDrawShow(playerid, closevpanel[playerid]);
	PlayerTextDrawShow(playerid, ngelock[playerid]);
	PlayerTextDrawShow(playerid, lampune[playerid]);
	PlayerTextDrawShow(playerid, nyalaknemesin[playerid]);
	PlayerTextDrawShow(playerid, hoodpanel[playerid]);
	PlayerTextDrawShow(playerid, trunkpanel[playerid]);
	PlayerTextDrawShow(playerid, neonpanel[playerid]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][15]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][16]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][17]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][18]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][19]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][20]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][21]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][22]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][23]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][24]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][25]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][26]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][27]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][28]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][29]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][30]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][31]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][32]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][33]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][34]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][35]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][36]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][37]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][38]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][39]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][40]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][41]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][42]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][43]);
	PlayerTextDrawShow(playerid, vpanellenz[playerid][44]);
}
function HidePanelLenz(playerid)
{
	PlayerTextDrawHide(playerid, vpanellenz[playerid][0]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][1]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][2]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][3]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][4]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][5]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][6]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][7]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][8]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][9]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][10]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][11]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][12]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][13]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][14]);
	PlayerTextDrawHide(playerid, closevpanel[playerid]);
	PlayerTextDrawHide(playerid, ngelock[playerid]);
	PlayerTextDrawHide(playerid, lampune[playerid]);
	PlayerTextDrawHide(playerid, nyalaknemesin[playerid]);
	PlayerTextDrawHide(playerid, hoodpanel[playerid]);
	PlayerTextDrawHide(playerid, trunkpanel[playerid]);
	PlayerTextDrawHide(playerid, neonpanel[playerid]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][15]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][16]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][17]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][18]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][19]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][20]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][21]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][22]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][23]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][24]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][25]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][26]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][27]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][28]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][29]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][30]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][31]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][32]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][33]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][34]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][35]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][36]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][37]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][38]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][39]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][40]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][41]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][42]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][43]);
	PlayerTextDrawHide(playerid, vpanellenz[playerid][44]);
}
function SambutanHilang(playerid)
{
	PlayerTextDrawHide(playerid, Sambutanku[playerid][0]);
	PlayerTextDrawHide(playerid, Sambutanku[playerid][1]);
}
function SambutanMuncul(playerid)
{
	PlayerTextDrawShow(playerid, Sambutanku[playerid][0]);
    new AtmInfo[560];
   	format(AtmInfo,1000,"%s", GetName(playerid));
	PlayerTextDrawSetString(playerid, Sambutanku[playerid][1], AtmInfo);
	PlayerTextDrawShow(playerid, Sambutanku[playerid][1]);
}
function Register(playerid)
{
    for(new i = 0; i < 16; i++)
	{
		PlayerTextDrawHide(playerid, MilehChar[playerid][i]);
	}
	PlayerTextDrawHide(playerid, ucptd[playerid]);
	PlayerTextDrawHide(playerid, karaktertd[playerid]);
	PlayerTextDrawHide(playerid, nyepawntd[playerid]);
	PlayerTextDrawHide(playerid, metutd[playerid]);  
 	CancelSelectTextDraw(playerid);
	return 1;
}

function hidePilihanSpawn(playerid)
{
	PlayerTextDrawHide(playerid, avalonspawn[playerid][0]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][1]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][2]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][3]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][4]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][5]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][6]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][7]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][8]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][9]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][10]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][11]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][12]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][13]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][14]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][15]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][16]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][17]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][18]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][19]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][20]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][21]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][22]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][23]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][24]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][25]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][26]);
	PlayerTextDrawHide(playerid, bandaraava[playerid]);
	PlayerTextDrawHide(playerid, stasiunava[playerid]);
	PlayerTextDrawHide(playerid, pelabuhanava[playerid]);
	PlayerTextDrawHide(playerid, fraksiava[playerid]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][27]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][28]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][29]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][30]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][31]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][32]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][33]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][34]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][35]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][36]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][37]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][38]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][39]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][40]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][41]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][42]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][43]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][44]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][45]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][46]);
	PlayerTextDrawHide(playerid, lastspawnava[playerid]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][47]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][48]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][49]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][50]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][51]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][52]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][53]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][54]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][55]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][56]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][57]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][58]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][59]);
	PlayerTextDrawHide(playerid, spawnava[playerid]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][60]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][61]);
	PlayerTextDrawHide(playerid, avalonspawn[playerid][62]);
	return 1;
}
function pilihanspawn(playerid)
{
	PlayerTextDrawShow(playerid, avalonspawn[playerid][0]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][1]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][2]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][3]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][4]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][5]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][6]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][7]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][8]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][9]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][10]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][11]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][12]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][13]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][14]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][15]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][16]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][17]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][18]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][19]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][20]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][21]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][22]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][23]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][24]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][25]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][26]);
	PlayerTextDrawShow(playerid, bandaraava[playerid]);
	PlayerTextDrawShow(playerid, stasiunava[playerid]);
	PlayerTextDrawShow(playerid, pelabuhanava[playerid]);
	PlayerTextDrawShow(playerid, fraksiava[playerid]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][27]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][28]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][29]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][30]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][31]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][32]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][33]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][34]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][35]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][36]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][37]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][38]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][39]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][40]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][41]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][42]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][43]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][44]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][45]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][46]);
	PlayerTextDrawShow(playerid, lastspawnava[playerid]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][47]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][48]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][49]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][50]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][51]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][52]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][53]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][54]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][55]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][56]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][57]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][58]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][59]);
	PlayerTextDrawShow(playerid, spawnava[playerid]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][60]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][61]);
	PlayerTextDrawShow(playerid, avalonspawn[playerid][62]);
	SelectTextDraw(playerid, COLOR_LBLUE);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	StopAudioStreamForPlayer(playerid);
	SetPlayerInterior(playerid, pData[playerid][pInt]);
	SetPlayerVirtualWorld(playerid, pData[playerid][pWorld]);
	SetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]+0.5);
	SetPlayerFacingAngle(playerid, pData[playerid][pPosA]);
	SetCameraBehindPlayer(playerid);
	TogglePlayerControllable(playerid, 0);
	SetPlayerSpawn(playerid);
	LoadAnims(playerid);
	pData[playerid][pTimeChit] = 0;
	//vpara[playerid]=0;

	SetPlayerSkillLevel(playerid, WEAPON_COLT45, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SILENCED, 1);
	SetPlayerSkillLevel(playerid, WEAPON_DEAGLE, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SHOTGUN, 1);
	//SetPlayerSkillLevel(playerid, WEAPON_SAWEDOFF, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SHOTGSPA, 1);
	SetPlayerSkillLevel(playerid, WEAPON_UZI, 1);
	SetPlayerSkillLevel(playerid, WEAPON_MP5, 1);
	SetPlayerSkillLevel(playerid, WEAPON_AK47, 1);
	SetPlayerSkillLevel(playerid, WEAPON_M4, 1);
	SetPlayerSkillLevel(playerid, WEAPON_TEC9, 1);
	SetPlayerSkillLevel(playerid, WEAPON_RIFLE, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SNIPER, 1);
	SetPlayerFightingStyle(playerid, pData[playerid][pFightStyle]);
	//GangZoneShowForAll(gzmap[0], 0x00FF00FF);
	/*GangZoneShowForAll(gzmap[0], 0x00FF00FF);
	GangZoneShowForAll(gzmap[1], 0x00FF00FF);
	GangZoneShowForAll(gzmap[2], 0x00FF00FF);
	GangZoneShowForAll(gzmap[3], 0x00FF00FF);
	GangZoneShowForAll(gzmap[4], 0x00FF00FF);
	GangZoneShowForAll(gzmap[4], 0x00FF00FF);
	GangZoneShowForAll(gzmap[6], 0x00FF00FF);
	GangZoneShowForAll(gzmap[7], 0x00FF00FF);
	GangZoneShowForAll(gzmap[8], 0x00FF00FF);
	GangZoneShowForAll(gzmap[9], 0x00FF00FF);
	GangZoneShowForAll(gzmap[10], 0x00FF00FF);
	GangZoneShowForAll(gzmap[11], 0x00FF00FF);
	GangZoneShowForAll(gzmap[12], 0x00FF00FF);
	GangZoneShowForAll(gzmap[14], 0x00FF00FF);
	GangZoneShowForAll(gzmap[13], 0x00FF00FF);
	GangZoneShowForAll(gzmap[15], 0x00FF00FF);
	GangZoneShowForAll(gzmap[16], 0x00FF00FF);
	GangZoneShowForAll(gzmap[17], 0x00FF00FF);
	GangZoneShowForAll(gzmap[19], 0x00FF00FF);
	GangZoneShowForAll(gzmap[18], 0x00FF00FF);
	GangZoneShowForAll(gzmap[20], 0x00FF00FF);
	GangZoneShowForAll(gzmap[21], 0x00FF00FF);
	GangZoneShowForAll(gzmap[22], 0x00FF00FF);
	GangZoneShowForAll(gzmap[23], 0x00FF00FF);
	GangZoneShowForAll(gzmap[24], 0xFF0000FF);*/

	return 1;
}

SetPlayerSpawn(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(pData[playerid][pGender] == 0)
		{
			TogglePlayerControllable(playerid,0);
			SetPlayerHealth(playerid, 100.0);
			SetPlayerArmour(playerid, 0.0);
			SetPlayerPos(playerid,1743.1216, -1862.2526, 13.5765);
			SetPlayerCameraPos(playerid,1214.0750, -1857.7932, 165.5676);
			SetPlayerCameraLookAt(playerid,1584.1112, -2395.8735, 76.4206);
			SetPlayerVirtualWorld(playerid, 0);
			ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Masukan tanggal lahir\n(Tgl/Bulan/Tahun)\nMisal : 15/04/1998", "Enter", "Batal");
		}
		else
		{
			if(pData[playerid][pHBEMode] == 1) //hbe old
			{
				for(new i = 0; i < 33; i++)
				{
					PlayerTextDrawShow(playerid, LenzHud[playerid][i]);
				}
				PlayerTextDrawShow(playerid, stresshud[playerid]);
				PlayerTextDrawShow(playerid, ombenhud[playerid]);
				PlayerTextDrawShow(playerid, manganhud[playerid]);
				PlayerTextDrawShow(playerid, sinyalhud[playerid]);
				PlayerTextDrawShow(playerid, duikhud[playerid]);
			}
			if(pData[playerid][pHBEMode] == 2) //hbe modern
			{
				for(new i = 0; i < 3; i++)
				{
					PlayerTextDrawShow(playerid, TryDevx[playerid][i]);
				}
				PlayerTextDrawShow(playerid, MakanTry[playerid]);
				PlayerTextDrawShow(playerid, MinumTry[playerid]);
				PlayerTextDrawShow(playerid, StressTry[playerid]);
			}
			if(pData[playerid][pHBEMode] == 3)
			{
				TextDrawShowForPlayer(playerid, HbeOprp[0]);
				TextDrawShowForPlayer(playerid, HbeOprp[1]);
				TextDrawShowForPlayer(playerid, HbeOprp[2]);
				TextDrawShowForPlayer(playerid, HbeOprp[3]);
				TextDrawShowForPlayer(playerid, HbeOprp[4]);
				TextDrawShowForPlayer(playerid, HbeOprp[5]);
				TextDrawShowForPlayer(playerid, HbeOprp[6]);
				TextDrawShowForPlayer(playerid, HbeOprp[7]);
				TextDrawShowForPlayer(playerid, HbeOprp[8]);
				TextDrawShowForPlayer(playerid, HbeOprp[9]);
				TextDrawShowForPlayer(playerid, HbeOprp[10]);
				TextDrawShowForPlayer(playerid, HbeOprp[11]);
			}
			PlayerTextDrawShow(playerid, LogoL3nz[playerid][0]);
			// PlayerTextDrawShow(playerid, LogoL3nz[playerid][1]);
			// PlayerTextDrawShow(playerid, LogoL3nz[playerid][2]);
			// PlayerTextDrawShow(playerid, LogoL3nz[playerid][3]);
			// PlayerTextDrawShow(playerid, LogoL3nz[playerid][4]);
			// PlayerTextDrawShow(playerid, LogoL3nz[playerid][5]);
			SetPlayerSkinEx(playerid, pData[playerid][pSkin]);
			SetPlayerColor(playerid, COLOR_WHITE);

			//for(new i = 0; i < 5; i++) 
			//{
			//	TextDrawHideForPlayer(playerid, WelcomeTD[i]);
			//}

			if(pData[playerid][pOnDuty] >= 1)
			{
				SetPlayerSkinEx(playerid, pData[playerid][pFacSkin]);
				SetFactionColor(playerid);
			}

			if(pData[playerid][pAdminDuty] > 0)
			{
				SetPlayerColor(playerid, COLOR_RED);
			}
			SetTimerEx("SpawnTimer", 4000, false, "i", playerid);
		}
	}
}

// function SpawnTimer(playerid)
// {
// 	ResetPlayerMoney(playerid);
// 	GivePlayerMoney(playerid, pData[playerid][pMoney]);
// 	SetPlayerScore(playerid, pData[playerid][pLevel]);
// 	SetPlayerHealth(playerid, pData[playerid][pHealth]);
// 	SetPlayerArmour(playerid, pData[playerid][pArmour]);
// 	pData[playerid][pSpawned] = 1;
// 	TogglePlayerControllable(playerid, true);
// 	SetCameraBehindPlayer(playerid);
// 	SedangAnterPizza[playerid] = 0;
// 	AttachPlayerToys(playerid);
// 	SetWeapons(playerid);
// 	if(pData[playerid][pJail] > 0)
// 	{
// 		JailPlayer(playerid); 
// 	}
// 	if(pData[playerid][pArrestTime] > 0)
// 	{
// 		SetPlayerArrest(playerid, pData[playerid][pArrest]);
// 	}  
//     return 1;    
// }
function SpawnTimer(playerid)
{
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, pData[playerid][pMoney]);
	SetPlayerScore(playerid, pData[playerid][pLevel]);
	SetPlayerHealth(playerid, pData[playerid][pHealth]);
	SetPlayerArmour(playerid, pData[playerid][pArmour]);
	pData[playerid][pSpawned] = 1;
	TogglePlayerControllable(playerid, true);
	SetCameraBehindPlayer(playerid);
	SedangAnterPizza[playerid] = 0;
	AttachPlayerToys(playerid);
	SetWeapons(playerid);
	if(pData[playerid][pJail] > 0)
	{
		JailPlayer(playerid);
	}
	if(pData[playerid][pArrestTime] > 0)
	{
		SetPlayerArrest(playerid, pData[playerid][pArrest]);
	}  
    return 1;    
}
public OnPlayerModelSelect(playerid, response, listid, modelid)
{	
	if(listid == PEDMale)
    {
		if(response)
		{
			pData[playerid][pFacSkin] = modelid;
			SetPlayerSkin(playerid, modelid);
			Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
		}
    }
	if(listid == PEDFemale)
    {
		if(response)
		{
			pData[playerid][pFacSkin] = modelid;
			SetPlayerSkin(playerid, modelid);
			Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
		}
    }
	return 1;
}
static const Float:cam_start_pos [4] [3] [6] =
{
	{
    	{2225.367919, -1341.228515, 26.527132, 1864.286499, -1511.908691, 160.707336},
    	{2220.424560, -1341.353149, 25.787668, 1860.622192, -1508.632812, 159.789916},
    	{2206.6897,-1344.4692,23.9844, 0.0, 0.0, 0.0}
	},
	{
    	{1705.268432, -576.238891, 39.012908, 1732.554321, -934.871826, 161.531326},
    	{1705.068969, -581.234924, 39.009002, 1729.563598, -938.804077, 160.761276},
    	{1673.0056,-712.7117,68.5703, 0.0, 0.0, 0.0}
	},
	{
    	{85.656761, -1339.051513, 89.242439, 24.335859, -1566.349487, 8.120280},
    	{87.708625, -1343.310302, 87.613655, 28.958576, -1564.447021, 8.224605},
    	{2.0860,-1355.8615,1.0736, 0.0, 0.0, 0.0}
	},
	{
    	{1705.268432, -576.238891, 39.012908, 1732.554321, -934.871826, 161.531326},
    	{1705.068969, -581.234924, 39.009002, 1729.563598, -938.804077, 160.761276},
    	{1673.0056,-712.7117,68.5703, 0.0, 0.0, 0.0}
	}
};
public OnPlayerRequestClass(playerid, classid)
{
    new rand = random(4);
	InterpolateCameraPos(playerid, cam_start_pos[rand][0][0], cam_start_pos[rand][0][1], cam_start_pos[rand][0][2], cam_start_pos[rand][0][3], cam_start_pos[rand][0][4], cam_start_pos[rand][0][5], 20000);
	InterpolateCameraLookAt(playerid, cam_start_pos[rand][1][0], cam_start_pos[rand][1][1], cam_start_pos[rand][1][2], cam_start_pos[rand][1][3], cam_start_pos[rand][1][4], cam_start_pos[rand][1][5], 20000);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	InfoMsg(playerid, "Jangan di pencet spawn bang!!!");
	KickEx(playerid);
	return 1;
}
stock IsPlayerNearPlayer(playerid, targetid, Float:radius)
{
	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetPlayerPos(targetid, fX, fY, fZ);

	return (GetPlayerInterior(playerid) == GetPlayerInterior(targetid) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid)) && IsPlayerInRangeOfPoint(playerid, radius, fX, fY, fZ);
}
function StressBerkurang(playerid)
{
	new rand = RandomEx(1, 2);
	pData[playerid][pBladder] -= rand;
}
stock SetRaceCP(playerid, type, Float:x, Float:y, Float:z, Float:range)
{
	DisablePlayerRaceCheckpoint(playerid);
	SetPlayerRaceCheckpoint(playerid, type, x, y, z, 0, 0, 0, range);
}
stock GiveMoneyRob(playerid, small, big)
{
	new money;
	new moneys[100];
	money = small+random(big);
	pData[playerid][pRedMoney] += money;
	format(moneys, sizeof moneys, "You have succesfull Robery, Getting : {00FF7F}%s", FormatMoney(money));
	SendClientMessage(playerid, 0xFFFFFF00, moneys);
}
stock SendTweetMessage(color, String[])
{
	foreach(new i : Player)
	{
		if(pData[i][pTogTweet] == 0)
		{
			SendClientMessageEx(i, color, String);
		}
	}
	return 1;
}

function FitnessTime(playerid)
{
    if(!IsValidTimer(pData[playerid][pActivity])) return 0;
	{
		if(pData[playerid][pActivityTime] >= 100)
		{
			InfoTD_MSG(playerid, 4000, "Done!");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pEnergy] -= 3;
			pData[playerid][pBladder] -= 2;
    		new asakit = RandomEx(0, 3);
    		new bsakit = RandomEx(0, 3);
    		pData[playerid][pRHand] += bsakit;
    		pData[playerid][pHead] += asakit;
            //InfoMsg(playerid, "Stress Anda Berkurang 8 Persen.");
            SendClientMessage(playerid, COLOR_YELLOW, "[GYM] Stress berkurang, dan Berhasil meningkatkan Kondisi Tubuh");
            SedangGym = 0;
			//UpFitStats(playerid, playerid);
			ClearAnimations(playerid);
			return 1;
		}
		else if(pData[playerid][pActivityTime] < 100)
		{
			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		}
	}
	return 1;
}
public OnPlayerDeath(playerid, killerid, reason)
{
	DeletePVar(playerid, "UsingSprunk");
	SetPVarInt(playerid, "GiveUptime", -1);
	PlayerLeaveSlots(playerid);
	Player_ResetCutting(playerid);
	Player_RemoveLumber(playerid);
	//Player_ResetMining(playerid);
	Player_ResetHarvest(playerid);
	//dron
    if( GetPVarInt( playerid, "DroneSpawned" ) == 1 ) {
    	SetPVarInt( playerid, "DroneSpawned", 0 );
    	DestroyVehicle( Drones[playerid] );
		Drones[playerid] = INVALID_VEHICLE_ID;
    	SendClientMessage( playerid, COLOR_GREEN, "Your drone was automatically shut down as you have died." );
	}

	pData[playerid][CarryProduct] = 0;
	pData[playerid][pProductingStatus] = 0;
	pData[playerid][pCookingStatus] = 0;
	pData[playerid][pMechanicStatus] = 0;
	pData[playerid][pActivityStatus] = 0;
	pData[playerid][pArmsDealerStatus] = 0;
	pData[playerid][pForklifterLoadStatus] = 0;
	pData[playerid][pForklifterUnLoadStatus] = 0;
	pData[playerid][pFillStatus] = 0;
	
	KillTimer(pData[playerid][pActivity]);
	KillTimer(pData[playerid][pMechanic]);
	KillTimer(pData[playerid][pProducting]);
	KillTimer(pData[playerid][pCooking]);
	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
	PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
	pData[playerid][pActivityTime] = 0;
	
	pData[playerid][pMechDuty] = 0;
	pData[playerid][pTaxiDuty] = 0;
	pData[playerid][pMission] = -1;
	
	pData[playerid][pSideJob] = 0;
	DisablePlayerCheckpoint(playerid);
	DisablePlayerRaceCheckpoint(playerid);
	SetPlayerColor(playerid, COLOR_WHITE);
	RemovePlayerAttachedObject(playerid, 9);
	GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
	foreach(new ii : Player)
    {
        if(pData[ii][pAdmin] > 0)
        {
        	new DCC_Channel:logkil;
        	logkil = DCC_FindChannelById("1286284984352768000");
            SendDeathMessageToPlayer(ii, killerid, playerid, reason);
            SendDeathMessage(ii, playerid, reason);
   			new lokasi[MAX_ZONE_NAME];
   			GetPlayer2DZone(playerid, lokasi, MAX_ZONE_NAME);
			//SendFactionMessage(3, ARWIN, "[SAMD KILL LOGS] {ffffff}Player %s[%d] down please respond samd, location %s", GetRPName(playerid), playerid, lokasi);
			//SendFactionMessage(1, COLOR_RED, "**[SAPD KILL LOGS] {FFFFFF}%s[%d] killed by %s[%d] weapon %s, location %s**", GetRPName(playerid), playerid, GetRPName(killerid), killerid, ReturnWeaponName(reason), lokasi);
			new dc[256];
			format(dc, sizeof(dc),  "[KILL LOGS] %s [%s] killed by %s [%s] weapon %s location %s", GetRPName(playerid), pData[playerid][pUCP], GetRPName(killerid), pData[killerid][pUCP], ReturnWeaponName(reason), lokasi);
			DCC_SendChannelMessage(logkil, dc);	
			return 1;
        }
    }
    if(IsAtEvent[playerid] == 1)
    {
    	SetPlayerPos(playerid, 1474.65, -1736.36, 13.38);
    	SetPlayerVirtualWorld(playerid, 0);
    	SetPlayerInterior(playerid, 0);
    	ClearAnimations(playerid);
    	ResetPlayerWeaponsEx(playerid);
       	SetPlayerColor(playerid, COLOR_WHITE);
    	if(GetPlayerTeam(playerid) == 1)
    	{
    		Servers(playerid, "Anda sudah terkalahkan");
    		RedTeam -= 1;
    	}
    	else if(GetPlayerTeam(playerid) == 2)
    	{
    		Servers(playerid, "Anda sudah terkalahkan");
    		BlueTeam -= 1;
    	}
    	if(BlueTeam == 0)
    	{
    		foreach(new ii : Player)
    		{
    			if(GetPlayerTeam(ii) == 1)
    			{
    				GivePlayerMoneyEx(ii, EventPrize);
    				Servers(ii, "Selamat, Tim Anda berhasil memenangkan Event dan Mendapatkan Hadiah $%d per orang", EventPrize);
    				pData[playerid][pHospital] = 0;
    				ClearAnimations(ii);
    				BlueTeam = 0;
    			}
    			else if(GetPlayerTeam(ii) == 2)
    			{
    				Servers(ii, "Maaf, Tim anda sudah terkalahkan, Harap Coba Lagi lain waktu");
    				pData[playerid][pHospital] = 0;
    				ClearAnimations(ii);
    				BlueTeam = 0;
    			}
    		}
    	}
    	if(RedTeam == 0)
    	{
    		foreach(new ii : Player)
    		{
    			if(GetPlayerTeam(ii) == 2)
    			{
    				GivePlayerMoneyEx(ii, EventPrize);
    				Servers(ii, "Selamat, Tim Anda berhasil memenangkan Event dan Mendapatkan Hadiah $%d per orang", EventPrize);
    				pData[playerid][pHospital] = 0;
    				ClearAnimations(ii);
    				BlueTeam = 0;
    			}
    			else if(GetPlayerTeam(ii) == 1)
    			{
    				Servers(ii, "Maaf, Tim anda sudah terkalahkan, Harap Coba Lagi lain waktu");
    				pData[playerid][pHospital] = 0;
    				ClearAnimations(ii);
    				RedTeam = 0;
    			}
    		}
    	}
    	SetPlayerTeam(playerid, 0);
    	IsAtEvent[playerid] = 0;
    	pData[playerid][pInjured] = 0;
    	pData[playerid][pSpawned] = 1;
		UpdateDynamic3DTextLabelText(pData[playerid][pInjuredLabel], COLOR_ORANGE, "");
    }
    if(IsAtEvent[playerid] == 0)
    {
    	new asakit = RandomEx(0, 5);
    	new bsakit = RandomEx(0, 9);
    	new csakit = RandomEx(0, 7);
    	new dsakit = RandomEx(0, 6);
    	pData[playerid][pLFoot] -= dsakit;
    	pData[playerid][pLHand] -= bsakit;
    	pData[playerid][pRFoot] -= csakit;
    	pData[playerid][pRHand] -= dsakit;
    	pData[playerid][pHead] -= asakit;
    }

	return 1;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ,Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	new weaponid = EditingWeapon[playerid];
    if(weaponid)
    {
        if(response == 1)
        {
            new enum_index = weaponid - 22, weaponname[18], string[340];
 
            GetWeaponName(weaponid, weaponname, sizeof(weaponname));
           
            WeaponSettings[playerid][enum_index][Position][0] = fOffsetX;
            WeaponSettings[playerid][enum_index][Position][1] = fOffsetY;
            WeaponSettings[playerid][enum_index][Position][2] = fOffsetZ;
            WeaponSettings[playerid][enum_index][Position][3] = fRotX;
            WeaponSettings[playerid][enum_index][Position][4] = fRotY;
            WeaponSettings[playerid][enum_index][Position][5] = fRotZ;
 
            RemovePlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid));
            SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][enum_index][Bone], fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, 1.0, 1.0, 1.0);
 
            Servers(playerid, "You have successfully adjusted the position of your %s.", weaponname);
           
            mysql_format(g_SQL, string, sizeof(string), "INSERT INTO weaponsettings (Owner, WeaponID, PosX, PosY, PosZ, RotX, RotY, RotZ) VALUES ('%d', %d, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f) ON DUPLICATE KEY UPDATE PosX = VALUES(PosX), PosY = VALUES(PosY), PosZ = VALUES(PosZ), RotX = VALUES(RotX), RotY = VALUES(RotY), RotZ = VALUES(RotZ)", pData[playerid][pID], weaponid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ);
            mysql_tquery(g_SQL, string);
        }
		else if(response == 0)
		{
			new enum_index = weaponid - 22;
			SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][enum_index][Bone], fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, 1.0, 1.0, 1.0);
		}
        EditingWeapon[playerid] = 0;
		return 1;
    }
	else
	{
		if(response == 1)
		{
			InfoTD_MSG(playerid, 4000, "Toy Position Updated!");

			pToys[playerid][index][toy_x] = fOffsetX;
			pToys[playerid][index][toy_y] = fOffsetY;
			pToys[playerid][index][toy_z] = fOffsetZ;
			pToys[playerid][index][toy_rx] = fRotX;
			pToys[playerid][index][toy_ry] = fRotY;
			pToys[playerid][index][toy_rz] = fRotZ;
			pToys[playerid][index][toy_sx] = fScaleX;
			pToys[playerid][index][toy_sy] = fScaleY;
			pToys[playerid][index][toy_sz] = fScaleZ;
			
			MySQL_SavePlayerToys(playerid);
			//UpdatePlayerStreamer(playerid);
		}
		SetPVarInt(playerid, "UpdatedToy", 1);
		//UpdatePlayerStreamer(playerid);
		TogglePlayerControllable(playerid, true);
	}
	return 1;
}

public OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT: objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(pData[playerid][EditingTreeID] != -1 && Iter_Contains(Trees, pData[playerid][EditingTreeID]))
	{
	    if(response == EDIT_RESPONSE_FINAL)
	    {
	        new etid = pData[playerid][EditingTreeID];
	        TreeData[etid][treeX] = x;
	        TreeData[etid][treeY] = y;
	        TreeData[etid][treeZ] = z;
	        TreeData[etid][treeRX] = rx;
	        TreeData[etid][treeRY] = ry;
	        TreeData[etid][treeRZ] = rz;

	        SetDynamicObjectPos(objectid, TreeData[etid][treeX], TreeData[etid][treeY], TreeData[etid][treeZ]);
	        SetDynamicObjectRot(objectid, TreeData[etid][treeRX], TreeData[etid][treeRY], TreeData[etid][treeRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[etid][treeLabel], E_STREAMER_X, TreeData[etid][treeX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[etid][treeLabel], E_STREAMER_Y, TreeData[etid][treeY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[etid][treeLabel], E_STREAMER_Z, TreeData[etid][treeZ] + 1.5);

		    Tree_Save(etid);
			//UpdatePlayerStreamer(playerid);
	        pData[playerid][EditingTreeID] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new etid = pData[playerid][EditingTreeID];
	        SetDynamicObjectPos(objectid, TreeData[etid][treeX], TreeData[etid][treeY], TreeData[etid][treeZ]);
	        SetDynamicObjectRot(objectid, TreeData[etid][treeRX], TreeData[etid][treeRY], TreeData[etid][treeRZ]);
	        pData[playerid][EditingTreeID] = -1;
			//UpdatePlayerStreamer(playerid);
	    }
	}
	if (pData[playerid][EditingSlotID] != -1)
	{
		new id = pData[playerid][EditingSlotID];
		if (Iter_Contains(Slots, id))
		{
		    if (response == EDIT_RESPONSE_FINAL)
		    {
		        SlotMachine[id][sPosX] = x;
				SlotMachine[id][sPosY] = y;
				SlotMachine[id][sPosZ] = z;

				SlotMachine[id][sRotX] = rx;
				SlotMachine[id][sRotY] = ry;
				SlotMachine[id][sRotZ] = rz;

		       	SlotMachine_Refresh(id, true);
			    SlotMachine_Save(id);
		        pData[playerid][EditingSlotID] = -1;
		    }
		    else if (response == EDIT_RESPONSE_CANCEL)
		    {
		        SlotMachine_Refresh(id, true);
		        pData[playerid][EditingSlotID] = -1;
		    }
		}
	}

    if(pData[playerid][EditingBerryID] != -1 && Iter_Contains(Berrys, pData[playerid][EditingBerryID]))
	{
	    if(response == EDIT_RESPONSE_FINAL)
	    {
	        new etid = pData[playerid][EditingBerryID];
	        BerryData[etid][berryX] = x;
	        BerryData[etid][berryY] = y;
	        BerryData[etid][berryZ] = z;
	        BerryData[etid][berryRX] = rx;
	        BerryData[etid][berryRY] = ry;
	        BerryData[etid][berryRZ] = rz;

	        SetDynamicObjectPos(objectid, BerryData[etid][berryX], BerryData[etid][berryY], BerryData[etid][berryZ]);
	        SetDynamicObjectRot(objectid, BerryData[etid][berryRX], BerryData[etid][berryRY], BerryData[etid][berryRZ]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BerryData[etid][berryLabel], E_STREAMER_X, BerryData[etid][berryX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BerryData[etid][berryLabel], E_STREAMER_Y, BerryData[etid][berryY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BerryData[etid][berryLabel], E_STREAMER_Z, BerryData[etid][berryZ] + 1.5);

		    Berry_Save(etid);
	        pData[playerid][EditingBerryID] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new etid = pData[playerid][EditingBerryID];
	        SetDynamicObjectPos(objectid, BerryData[etid][berryX], BerryData[etid][berryY], BerryData[etid][berryZ]);
	        SetDynamicObjectRot(objectid, BerryData[etid][berryRX], BerryData[etid][berryRY], BerryData[etid][berryRZ]);
	        pData[playerid][EditingBerryID] = -1;
	    }
	}
	if(pData[playerid][EditingSPEEDCAM] != -1 && Iter_Contains(Speedcam, pData[playerid][EditingSPEEDCAM]))
	{
		if(response == EDIT_RESPONSE_FINAL)
	    {
	        new camid = pData[playerid][EditingSPEEDCAM];
	        camData[camid][camX] = x;
	        camData[camid][camY] = y;
	        camData[camid][camZ] = z;
	        camData[camid][camRX] = rx;
	        camData[camid][camRY] = ry;
	        camData[camid][camRZ] = rz;

	        SetDynamicObjectPos(objectid, camData[camid][camX], camData[camid][camY], camData[camid][camZ]);
	        SetDynamicObjectRot(objectid, camData[camid][camRX], camData[camid][camRY], camData[camid][camRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, camData[camid][camLabel], E_STREAMER_X, camData[camid][camX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, camData[camid][camLabel], E_STREAMER_Y, camData[camid][camY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, camData[camid][camLabel], E_STREAMER_Z, camData[camid][camZ] + 3.5);

		    Speedcam_Save(camid);
	        pData[playerid][EditingSPEEDCAM] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new camid = pData[playerid][EditingSPEEDCAM];
	        SetDynamicObjectPos(objectid, camData[camid][camX], camData[camid][camY], camData[camid][camZ]);
	        SetDynamicObjectRot(objectid, camData[camid][camRX], camData[camid][camRY], camData[camid][camRZ]);
	        pData[playerid][EditingSPEEDCAM] = -1;
	    }
	}
	if(pData[playerid][EditingSIGNAL] != -1 && Iter_Contains(Signal, pData[playerid][EditingSIGNAL]))
	{
		if(response == EDIT_RESPONSE_FINAL)
	    {
	        new sgid = pData[playerid][EditingSIGNAL];
	        sgData[sgid][sgX] = x;
	        sgData[sgid][sgY] = y;
	        sgData[sgid][sgZ] = z;
	        sgData[sgid][sgRX] = rx;
	        sgData[sgid][sgRY] = ry;
	        sgData[sgid][sgRZ] = rz;

	        SetDynamicObjectPos(objectid, sgData[sgid][sgX], sgData[sgid][sgY], sgData[sgid][sgZ]);
	        SetDynamicObjectRot(objectid, sgData[sgid][sgRX], sgData[sgid][sgRY], sgData[sgid][sgRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, sgData[sgid][sgLabel], E_STREAMER_X, sgData[sgid][sgX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, sgData[sgid][sgLabel], E_STREAMER_Y, sgData[sgid][sgY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, sgData[sgid][sgLabel], E_STREAMER_Z, sgData[sgid][sgZ] + 3.5);

		    Signal_Save(sgid);
	        pData[playerid][EditingSIGNAL] = -1;
	    }

	    else if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new sgid = pData[playerid][EditingSIGNAL];
	        SetDynamicObjectPos(objectid, sgData[sgid][sgX], sgData[sgid][sgY], sgData[sgid][sgZ]);
	        SetDynamicObjectRot(objectid, sgData[sgid][sgRX], sgData[sgid][sgRY], sgData[sgid][sgRZ]);
	        pData[playerid][EditingSIGNAL] = -1;
	    }
	}
	/*if(pData[playerid][EditingOreID] != -1 && Iter_Contains(Ores, pData[playerid][EditingOreID]))
	{
	    if(response == EDIT_RESPONSE_FINAL)
	    {
	        new etid = pData[playerid][EditingOreID];
	        OreData[etid][oreX] = x;
	        OreData[etid][oreY] = y;
	        OreData[etid][oreZ] = z;
	        OreData[etid][oreRX] = rx;
	        OreData[etid][oreRY] = ry;
	        OreData[etid][oreRZ] = rz;

	        SetDynamicObjectPos(objectid, OreData[etid][oreX], OreData[etid][oreY], OreData[etid][oreZ]);
	        SetDynamicObjectRot(objectid, OreData[etid][oreRX], OreData[etid][oreRY], OreData[etid][oreRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, OreData[etid][oreLabel], E_STREAMER_X, OreData[etid][oreX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, OreData[etid][oreLabel], E_STREAMER_Y, OreData[etid][oreY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, OreData[etid][oreLabel], E_STREAMER_Z, OreData[etid][oreZ] + 1.5);

		    Ore_Save(etid);
			//UpdatePlayerStreamer(playerid);
	        pData[playerid][EditingOreID] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new etid = pData[playerid][EditingOreID];
	        SetDynamicObjectPos(objectid, OreData[etid][oreX], OreData[etid][oreY], OreData[etid][oreZ]);
	        SetDynamicObjectRot(objectid, OreData[etid][oreRX], OreData[etid][oreRY], OreData[etid][oreRZ]);
	        pData[playerid][EditingOreID] = -1;
			//UpdatePlayerStreamer(playerid);
	    }
	}*/
	if(pData[playerid][EditingATMID] != -1 && Iter_Contains(ATMS, pData[playerid][EditingATMID]))
	{
		if(response == EDIT_RESPONSE_FINAL)
	    {
	        new etid = pData[playerid][EditingATMID];
	        AtmData[etid][atmX] = x;
	        AtmData[etid][atmY] = y;
	        AtmData[etid][atmZ] = z;
	        AtmData[etid][atmRX] = rx;
	        AtmData[etid][atmRY] = ry;
	        AtmData[etid][atmRZ] = rz;

	        SetDynamicObjectPos(objectid, AtmData[etid][atmX], AtmData[etid][atmY], AtmData[etid][atmZ]);
	        SetDynamicObjectRot(objectid, AtmData[etid][atmRX], AtmData[etid][atmRY], AtmData[etid][atmRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, AtmData[etid][atmLabel], E_STREAMER_X, AtmData[etid][atmX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, AtmData[etid][atmLabel], E_STREAMER_Y, AtmData[etid][atmY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, AtmData[etid][atmLabel], E_STREAMER_Z, AtmData[etid][atmZ] + 0.3);

		    Atm_Save(etid);
			//UpdatePlayerStreamer(playerid);
	        pData[playerid][EditingATMID] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new etid = pData[playerid][EditingATMID];
	        SetDynamicObjectPos(objectid, AtmData[etid][atmX], AtmData[etid][atmY], AtmData[etid][atmZ]);
	        SetDynamicObjectRot(objectid, AtmData[etid][atmRX], AtmData[etid][atmRY], AtmData[etid][atmRZ]);
	        pData[playerid][EditingATMID] = -1;
			//UpdatePlayerStreamer(playerid);
	    }
	}
	if(pData[playerid][EditingVending] != -1 && Iter_Contains(Vendings, pData[playerid][EditingVending]))
	{
		if(response == EDIT_RESPONSE_FINAL)
	    {
	        new venid = pData[playerid][EditingVending];
	        VendingData[venid][vendingX] = x;
	        VendingData[venid][vendingY] = y;
	        VendingData[venid][vendingZ] = z;
	        VendingData[venid][vendingRX] = rx;
	        VendingData[venid][vendingRY] = ry;
	        VendingData[venid][vendingRZ] = rz;

	        SetDynamicObjectPos(objectid, VendingData[venid][vendingX], VendingData[venid][vendingY], VendingData[venid][vendingZ]);
	        SetDynamicObjectRot(objectid, VendingData[venid][vendingRX], VendingData[venid][vendingRY], VendingData[venid][vendingRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, VendingData[venid][vendingText], E_STREAMER_X, VendingData[venid][vendingX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, VendingData[venid][vendingText], E_STREAMER_Y, VendingData[venid][vendingY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, VendingData[venid][vendingText], E_STREAMER_Z, VendingData[venid][vendingZ] + 0.3);

		    Vending_Save(venid);
			//UpdatePlayerStreamer(playerid);
	        pData[playerid][EditingVending] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new venid = pData[playerid][EditingVending];
	        SetDynamicObjectPos(objectid, VendingData[venid][vendingX], VendingData[venid][vendingY], VendingData[venid][vendingZ]);
	        SetDynamicObjectRot(objectid, VendingData[venid][vendingRX], VendingData[venid][vendingRY], VendingData[venid][vendingRZ]);
	    	pData[playerid][EditingVending] = -1;
			//UpdatePlayerStreamer(playerid);
	    }
	}
	if(pData[playerid][gEditID] != -1 && Iter_Contains(Gates, pData[playerid][gEditID]))
	{
		new id = pData[playerid][gEditID];
		if(response == EDIT_RESPONSE_UPDATE)
		{
			SetDynamicObjectPos(objectid, x, y, z);
			SetDynamicObjectRot(objectid, rx, ry, rz);
			//UpdatePlayerStreamer(playerid);
		}
		else if(response == EDIT_RESPONSE_CANCEL)
		{
			SetDynamicObjectPos(objectid, gPosX[playerid], gPosY[playerid], gPosZ[playerid]);
			SetDynamicObjectRot(objectid, gRotX[playerid], gRotY[playerid], gRotZ[playerid]);
			gPosX[playerid] = 0; gPosY[playerid] = 0; gPosZ[playerid] = 0;
			gRotX[playerid] = 0; gRotY[playerid] = 0; gRotZ[playerid] = 0;
			Servers(playerid, " You have canceled editing gate ID %d.", id);
			Gate_Save(id);
			//UpdatePlayerStreamer(playerid);
		}
		else if(response == EDIT_RESPONSE_FINAL)
		{
			SetDynamicObjectPos(objectid, x, y, z);
			SetDynamicObjectRot(objectid, rx, ry, rz);
			if(pData[playerid][gEdit] == 1)
			{
				gData[id][gCX] = x;
				gData[id][gCY] = y;
				gData[id][gCZ] = z;
				gData[id][gCRX] = rx;
				gData[id][gCRY] = ry;
				gData[id][gCRZ] = rz;
				if(IsValidDynamic3DTextLabel(gData[id][gText])) DestroyDynamic3DTextLabel(gData[id][gText]);
				new str[64];
				format(str, sizeof(str), "Gate ID: %d", id);
				gData[id][gText] = CreateDynamic3DTextLabel(str, COLOR_WHITE, gData[id][gCX], gData[id][gCY], gData[id][gCZ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 10.0);
				
				pData[playerid][gEditID] = -1;
				pData[playerid][gEdit] = 0;
				Servers(playerid, " You have finished editing gate ID %d's closing position.", id);
				gData[id][gStatus] = 0;
				Gate_Save(id);
			}
			else if(pData[playerid][gEdit] == 2)
			{
				gData[id][gOX] = x;
				gData[id][gOY] = y;
				gData[id][gOZ] = z;
				gData[id][gORX] = rx;
				gData[id][gORY] = ry;
				gData[id][gORZ] = rz;
				
				pData[playerid][gEditID] = -1;
				pData[playerid][gEdit] = 0;
				Servers(playerid, " You have finished editing gate ID %d's opening position.", id);

				gData[id][gStatus] = 1;
				Gate_Save(id);
				//UpdatePlayerStreamer(playerid);
			}
		}
	}
	//graf
	if(response == EDIT_RESPONSE_FINAL )
	{
		if(GetPVarInt(playerid, "GraffitiCreating") == 1 )
		{
			new id = nGraffiti();
	        gInfo[id][Xpos] = x;
	        gInfo[id][Ypos] = y;
	        gInfo[id][Zpos] = z;
	        gInfo[id][XYpos] = rx;
	        gInfo[id][YYpos] = ry;
	        gInfo[id][ZYpos] = rz;

	        SetDynamicObjectPos(objectid, gInfo[id][Xpos], gInfo[id][Ypos], gInfo[id][Zpos]);
	        SetDynamicObjectRot(objectid, gInfo[id][XYpos], gInfo[id][YYpos], gInfo[id][ZYpos]);
		}
	}
	if( response == EDIT_RESPONSE_CANCEL )
	{
		if(GetPVarInt(playerid, "GraffitiCreating") == 1 )
		{
			DestroyDynamicObject( POBJECT[playerid] );
			SendClientMessage( playerid,0xFF6800FF,"Creation of Graffiti Canceled" ); // <---
			DeletePVar( playerid,"GraffitiCreating" );
		}
	}
    new String[10000];
    new idx = gymEditID[playerid];
	if(response == EDIT_RESPONSE_UPDATE)
	{
	    SetDynamicObjectPos(objectid, x, y, z);
		SetDynamicObjectRot(objectid, rx, ry, rz);
	}
	else if(response == EDIT_RESPONSE_CANCEL)
	{
	    if(gymEditID[playerid] != 0)
	    {
		    SetDynamicObjectPos(objectid, gymObjectPos[playerid][0], gymObjectPos[playerid][1], gymObjectPos[playerid][2]);
			SetDynamicObjectRot(objectid, gymObjectRot[playerid][0], gymObjectRot[playerid][1], gymObjectRot[playerid][2]);
			gymObjectPos[playerid][0] = 0; gymObjectPos[playerid][1] = 0; gymObjectPos[playerid][2] = 0;
			gymObjectRot[playerid][0] = 0; gymObjectRot[playerid][1] = 0; gymObjectRot[playerid][2] = 0;
			gymEdit[playerid] = 0;
			gymEditID[playerid] = 0;
		}
	}
	else if(response == EDIT_RESPONSE_FINAL)
	{
		SetDynamicObjectPos(objectid, x, y, z);
		SetDynamicObjectRot(objectid, rx, ry, rz);
		if(gymEdit[playerid] == 1)
		{
		    GYMInfo[idx][GYMOBJPos][0] = x;
	        GYMInfo[idx][GYMOBJPos][1] = y;
	        GYMInfo[idx][GYMOBJPos][2] = z;
	        GYMInfo[idx][GYMOBJPos][3] = rx;
	        GYMInfo[idx][GYMOBJPos][4] = ry;
	        GYMInfo[idx][GYMOBJPos][5] = rz;
	        GYMInfo[idx][GYMvw] = GetPlayerVirtualWorld(playerid);
        	GYMInfo[idx][GYMint] = GetPlayerInterior(playerid);
	        DestroyDynamic3DTextLabel(GYMInfo[idx][GYMOBJText]);
   			format(String, 128, "[ID:%d]\n{00FF00}Available\n%d/1000", idx, GYMInfo[idx][GYMOBJCondition]);
			GYMInfo[idx][GYMOBJText] = CreateDynamic3DTextLabel(String, COLOR_YELLOW, GYMInfo[idx][GYMOBJPos][0], GYMInfo[idx][GYMOBJPos][1], GYMInfo[idx][GYMOBJPos][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GYMInfo[idx][GYMvw], GYMInfo[idx][GYMint], -1, 10.0);
			SaveGYMObject();
		    gymEdit[playerid] = 0;
		    gymEditID[playerid] = 0;
		}
	}
	//--
	/*if (pData[playerid][pEditFlat] != -1 && FlatData[pData[playerid][pEditFlat]][flatExists])
	{
		if(response == EDIT_RESPONSE_FINAL)
		{
			new id = pData[playerid][pEditFlat];

			FlatData[pData[playerid][pEditFlat]][flatPos][0] = x;
			FlatData[pData[playerid][pEditFlat]][flatPos][1] = y;
			FlatData[pData[playerid][pEditFlat]][flatPos][2] = z;
			FlatData[pData[playerid][pEditFlat]][flatPos][3] = rx;
			FlatData[pData[playerid][pEditFlat]][flatPos][4] = ry;
			FlatData[pData[playerid][pEditFlat]][flatPos][5] = rz;

			Flat_Save(id);
			Flat_Refresh(pData[playerid][pEditFlat]);
			Servers(playerid, "You have edited the position of Flat Door ID: %d.", id);
		}
		else if(response == EDIT_RESPONSE_CANCEL)
		{
			new id = pData[playerid][pEditFlat];
			
			Flat_Save(id);
			Flat_Refresh(pData[playerid][pEditFlat]);
	    	pData[playerid][pEditFlat] = -1;*/
	return 1;
}
//boombox


forward OnSecondTimer();
public OnSecondTimer()
{
	new minute;
	gettime(_, minute);

	foreach(new playerid : Player)
	{
		CallLocalFunction("OnPlayerTimer", "i", playerid);
	}
}

forward OnPlayersWorldTimeInit(hour, minute);
public OnPlayersWorldTimeInit(hour, minute)
{
	foreach(new playerid : Player)
	{
		SetPlayerTime(playerid, hour, minute);
	}
}

public OnPlayerLeaveCheckpoint(playerid)
{
	if(ShowCylinderNotif[playerid]) HideCylinderText(playerid);
	if(pData[playerid][pBus] && IsABusVeh(GetPlayerVehicleID(playerid)))
	{
		pData[playerid][pBuswaiting] = false;
		InfoTD_Hide(playerid);
	}
	return 1;
}


public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	/*if(checkpointid == pData[playerid][LoadingPoint])
	{
	    if(GetPVarInt(playerid, "LoadingCooldown") > gettime()) return 1;
		new vehicleid = GetPVarInt(playerid, "LastVehicleID"), type[64], carid = -1;
		if(pData[playerid][CarryingLog] == 0)
		{
			type = "Metal";
		}
		else if(pData[playerid][CarryingLog] == 1)
		{
			type = "Coal";
		}
		else
		{
			type = "Unknown";
		}
		if(Vehicle_LogCount(vehicleid) >= LOG_LIMIT) return ErrorMsg(playerid, "You can't load any more ores to this vehicle.");
		if((carid = Vehicle_Nearest2(playerid)) != -1)
		{
			if(pData[playerid][CarryingLog] == 0)
			{
				pvData[carid][cMetal] += 1;
			}
			else if(pData[playerid][CarryingLog] == 1)
			{
				pvData[carid][cCoal] += 1;
			}
		}
		LogStorage[vehicleid][ pData[playerid][CarryingLog] ]++;
		Info(playerid, "MINING: Loaded %s.", type);
		ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, 0, 1, 1, 0, 0, 1);
		Player_RemoveLog(playerid);
		return 1;
	}*/
	if(checkpointid == SmugglerCP)
	{
		if(pData[playerid][pTakePacket] == true)
		{
			//StartPlayerLoadingBar(playerid, 3, "Proses...");
			InfoTD_MSG(playerid, 2000, "Delivering Packet..");
			ApplyAnimation(playerid,"BOMBER","BOM_Plant",10.0,0 ,0,0,0,0,1);
			new Price = RandomEx(700, 1100);
			GivePlayerMoneyEx(playerid, Price);
		    pData[playerid][pRedMoney] += Price;
			RemovePlayerAttachedObject(playerid, 3);
		    DisablePlayerCheckpoint(playerid);
			Info(playerid, "Successfully Delivery Packet and you get %s", FormatMoney(Price));

			pData[playerid][pTakePacket] = false;
		}
	}
	if(checkpointid == Disnaker)
	{
		//InfoMsg(playerid, "Otot ALT Untuk Ambil Job");
		ShowCylinderText(playerid, "Otot ALT Untuk Ambil Job");
	}
	if(checkpointid == Cafe)
	{
		ShowCylinderText(playerid, "Otot ALT Untuk Memesan");
	}
	if(checkpointid == PenambangArea[playerid][Nambang])
	{
		ShowCylinderText(playerid, "Otot ALT Untuk memulai menambang");
	}
	if(checkpointid == PenambangArea[playerid][Nambang2])
	{
		ShowCylinderText(playerid, "Otot ALT Untuk memulai menambang");
	}
	if(checkpointid == PenambangArea[playerid][Nambang3])
	{
		ShowCylinderText(playerid, "Otot ALT Untuk memulai menambang");
	}
	if(checkpointid == PenambangArea[playerid][Nambang4])
	{
		ShowCylinderText(playerid, "Otot ALT Untuk memulai menambang");
	}
	if(checkpointid == PenambangArea[playerid][Nambang5])
	{
		ShowCylinderText(playerid, "Otot ALT Untuk memulai menambang");
	}
	if(checkpointid == PenambangArea[playerid][Nambang6])
	{
		ShowCylinderText(playerid, "Otot ALT Untuk memulai menambang");
	}
	if(checkpointid == PenambangArea[playerid][CuciBatu])
	{
		ShowCylinderText(playerid, "Otot ALT Untuk mencuci batu");
	}
	if(checkpointid == PenambangArea[playerid][Peleburan])
	{
		ShowCylinderText(playerid, "Otot ALT Untuk meleburkan batu");
	}
	if(checkpointid == MinyakArea[playerid][OlahMinyak])
	{
		ShowCylinderText(playerid, "Otot ALT Untuk mengolah minyak");
	}
	if(checkpointid == MinyakArea[playerid][Nambangg])
	{
		ShowCylinderText(playerid, "Otot ALT Untuk mengambil minyak");
	}
	if(checkpointid == MinyakArea[playerid][Nambang])
	{
		ShowCylinderText(playerid, "Otot ALT Untuk mengambil minyak");
	}



	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	switch(pData[playerid][pCheckPoint])
	{
		case CHECKPOINT_BAGGAGE:
		{
			if(pData[playerid][pBaggage] > 0)
			{
				if(pData[playerid][pBaggage] == 1)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 2;
					SetPlayerRaceCheckpoint(playerid, 1, 1524.4792, -2435.2844, 13.2118, 1524.4792, -2435.2844, 13.2118, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 2)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 3;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						pData[playerid][pTrailerBaggage] = INVALID_VEHICLE_ID;
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2087.7998, -2392.8328, 13.2083, 2087.7998, -2392.8328, 13.2083, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(606, 2087.7998, -2392.8328, 13.2083, 179.9115, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 3)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 4;
					SetPlayerRaceCheckpoint(playerid, 1, 1605.2043, -2435.4360, 13.2153, 1605.2043, -2435.4360, 13.2153, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 4)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 5;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						pData[playerid][pTrailerBaggage] = INVALID_VEHICLE_ID;
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2006.6425, -2340.5103, 13.2045, 2006.6425, -2340.5103, 13.2045, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(607, 2006.6425, -2340.5103, 13.2045, 90.0068, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 5)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 6;
					SetPlayerRaceCheckpoint(playerid, 1, 1684.9463, -2435.2239, 13.2137, 1684.9463, -2435.2239, 13.2137, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 6)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 7;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						pData[playerid][pTrailerBaggage] = INVALID_VEHICLE_ID;
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2006.4136, -2273.7458, 13.2012, 2006.4136, -2273.7458, 13.2012, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(607, 2006.4136, -2273.7458, 13.2012, 92.4049, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 7)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 8;
					SetPlayerRaceCheckpoint(playerid, 1, 1765.8700, -2435.1189, 13.2090, 1765.8700, -2435.1189, 13.2090, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 8)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 9;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						pData[playerid][pTrailerBaggage] = INVALID_VEHICLE_ID;
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2056.9043, -2392.0959, 13.2038, 2056.9043, -2392.0959, 13.2038, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(606, 2056.9043, -2392.0959, 13.2038, 179.4666, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 9)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 10;
					SetPlayerRaceCheckpoint(playerid, 1, 1524.1018, -2435.0664, 13.2139, 1524.1018, -2435.0664, 13.2139, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 10)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 11;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						pData[playerid][pTrailerBaggage] = INVALID_VEHICLE_ID;
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint terakhir di GPSmu, Untuk mendapatkan gajimu!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2099.8982, -2200.7234, 13.2042, 2099.8982, -2200.7234, 13.2042, 5.0);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 11)
				{
					new vehicleid = GetPlayerVehicleID(playerid);
					DisablePlayerRaceCheckpoint(playerid);
					pData[playerid][pBaggage] = 0;
					pData[playerid][pJobTime] += 1380;
					pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
					DialogBaggage[0] = false;
					MyBaggage[playerid][0] = false;
					ShowItemBox(playerid, "Uang", "Received_200x", 1212, 2);
					// GivePlayerMoneyEx(playerid, 200);
					AddPlayerSalary(playerid, "SideJob (Baggage)", 200);
					InfoMsg(playerid, "SideJob(Baggage) telah masuk ke pending salary anda!");
					RemovePlayerFromVehicle(playerid);
					SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					return 1;
				}
				//RUTE BAGGGAGE 2
				else if(pData[playerid][pBaggage] == 12)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 13;
					SetPlayerRaceCheckpoint(playerid, 1, 1891.7626, -2638.8113, 13.2074, 1891.7626, -2638.8113, 13.2074, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 13)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 14;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						pData[playerid][pTrailerBaggage] = INVALID_VEHICLE_ID;
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2007.5886, -2406.7236, 13.2065, 2007.5886, -2406.7236, 13.2065, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(606, 2007.5886, -2406.7236, 13.2065, 85.9836, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 14)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 15;
					SetPlayerRaceCheckpoint(playerid, 1, 1822.6267, -2637.9224, 13.2049, 1822.6267, -2637.9224, 13.2049, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 15)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 16;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						pData[playerid][pTrailerBaggage] = INVALID_VEHICLE_ID;
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2007.2054, -2358.0920, 13.2030, 2007.2054, -2358.0920, 13.2030, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(607, 2007.2054, -2358.0920, 13.2030, 89.7154, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 16)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 17;
					SetPlayerRaceCheckpoint(playerid, 1, 1617.9980, -2638.5725, 13.2034, 1617.9980, -2638.5725, 13.2034, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 17)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 18;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						pData[playerid][pTrailerBaggage] = INVALID_VEHICLE_ID;
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 1874.9221, -2348.8616, 13.2039, 1874.9221, -2348.8616, 13.2039, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(607, 1874.9221, -2348.8616, 13.2039, 274.8172, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 18)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 19;
					SetPlayerRaceCheckpoint(playerid, 1, 1681.0703, -2638.5410, 13.2045, 1681.0703, -2638.5410, 13.2045, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 19)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 20;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						pData[playerid][pTrailerBaggage] = INVALID_VEHICLE_ID;
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 1424.8074, -2415.5378, 13.2094, 1424.8074, -2415.5378, 13.2094, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(606, 1424.8074, -2415.5378, 13.2094, 268.7459, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 20)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 21;
					SetPlayerRaceCheckpoint(playerid, 1, 1755.4872, -2639.1306, 13.2014, 1755.4872, -2639.1306, 13.2014, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 21)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 22;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						pData[playerid][pTrailerBaggage] = INVALID_VEHICLE_ID;
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint terakhir di GPSmu, Untuk mendapatkan gajimu!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2110.0212, -2211.1377, 13.2008, 2110.0212, -2211.1377, 13.2008, 5.0);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 22)
				{
					new vehicleid = GetPlayerVehicleID(playerid);
					DisablePlayerRaceCheckpoint(playerid);
					pData[playerid][pBaggage] = 0;
					pData[playerid][pJobTime] += 1380;
					pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
					DialogBaggage[1] = false;
					MyBaggage[playerid][1] = false;
					ShowItemBox(playerid, "Uang", "Received_200x", 1212, 2);
					AddPlayerSalary(playerid, "SideJob (Baggage)", 200);
					InfoMsg(playerid, "SideJob(Baggage) telah masuk ke pending salary anda!");					
					// GivePlayerMoneyEx(playerid, 200);
					RemovePlayerFromVehicle(playerid);
					SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					return 1;
				}
				//RUTE BAGGAGE 3
				else if(pData[playerid][pBaggage] == 23)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 24;
					SetPlayerRaceCheckpoint(playerid, 1, 1509.5022, -2431.4277, 13.2163, 1509.5022, -2431.4277, 13.2163, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 24)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 25;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						pData[playerid][pTrailerBaggage] = INVALID_VEHICLE_ID;
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 1913.4680, -2678.1877, 13.2135, 1913.4680, -2678.1877, 13.2135, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(606, 1913.4680, -2678.1877, 13.2135, 358.3546, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 25)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 26;
					SetPlayerRaceCheckpoint(playerid, 1, 1591.0934, -2432.3208, 13.2094, 1591.0934, -2432.3208, 13.2094, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 26)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 27;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						pData[playerid][pTrailerBaggage] = INVALID_VEHICLE_ID;
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 1593.1262, -2685.6423, 13.2016, 1593.1262, -2685.6423, 13.2016, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(607, 1593.1262, -2685.6423, 13.2016, 359.1027, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 27)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 28;
					SetPlayerRaceCheckpoint(playerid, 1, 1751.1523, -2432.6274, 13.2132, 1751.1523, -2432.6274, 13.2132, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 28)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 29;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						pData[playerid][pTrailerBaggage] = INVALID_VEHICLE_ID;
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 1706.6799, -2686.6472, 13.2031, 1706.6799, -2686.6472, 13.2031, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(607, 1706.6799, -2686.6472, 13.2031, 358.5210, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 29)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 30;
					SetPlayerRaceCheckpoint(playerid, 1, 1892.2029, -2344.9568, 13.2069, 1892.2029, -2344.9568, 13.2069, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 30)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 31;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						pData[playerid][pTrailerBaggage] = INVALID_VEHICLE_ID;
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2160.3184, -2390.0625, 13.2055, 2160.3184, -2390.0625, 13.2055, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(606, 2160.3184, -2390.0625, 13.2055, 157.5291, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 31)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 32;
					SetPlayerRaceCheckpoint(playerid, 1, 1891.8900, -2261.1121, 13.2071, 1891.8900, -2261.1121, 13.2071, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 32)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 33;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						pData[playerid][pTrailerBaggage] = INVALID_VEHICLE_ID;
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mendapatkan gajimu!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2087.1458, -2192.2161, 13.2047, 2087.1458, -2192.2161, 13.2047, 5.0);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 33)
				{
					new vehicleid = GetPlayerVehicleID(playerid);
					DisablePlayerRaceCheckpoint(playerid);
					pData[playerid][pBaggage] = 0;
					pData[playerid][pJobTime] += 1380;
					pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
					DialogBaggage[2] = false;
					MyBaggage[playerid][2] = false;
					ShowItemBox(playerid, "Uang", "Received_200x", 1212, 2);
					AddPlayerSalary(playerid, "SideJob (Baggage)", 200);
					InfoMsg(playerid, "SideJob(Baggage) telah masuk ke pending salary anda!");					
					// GivePlayerMoneyEx(playerid, 200);
					RemovePlayerFromVehicle(playerid);
					SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					return 1;
				}	
			}
		}
		case CHECKPOINT_DRIVELIC:
		{
			if(pData[playerid][pDriveLicApp] > 0)
			{
				if(pData[playerid][pDriveLicApp] == 1)
				{
					pData[playerid][pDriveLicApp] = 2;
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint2, dmvpoint2, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 2)
				{
					pData[playerid][pDriveLicApp] = 3;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint3, dmvpoint3, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 3)
				{
					pData[playerid][pDriveLicApp] = 4;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint4, dmvpoint4, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 4)
				{
					pData[playerid][pDriveLicApp] = 5;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint5, dmvpoint5, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 5)
				{
					pData[playerid][pDriveLicApp] = 6;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint6, dmvpoint6, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 6)
				{
					pData[playerid][pDriveLicApp] = 7;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint7, dmvpoint7, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 7)
				{
					pData[playerid][pDriveLicApp] = 8;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint8, dmvpoint8, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 8)
				{
					pData[playerid][pDriveLicApp] = 9;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint9, dmvpoint9, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 9)
				{
					pData[playerid][pDriveLicApp] = 10;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint10, dmvpoint10, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 10)
				{
					pData[playerid][pDriveLicApp] = 11;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint11, dmvpoint11, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 11)
				{
					new vehicleid = GetPlayerVehicleID(playerid);
					pData[playerid][pDriveLicApp] = 0;
					pData[playerid][pDriveLic] = 1;
					pData[playerid][pDriveLicTime] = gettime() + (30 * 86400);
					pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
					DisablePlayerRaceCheckpoint(playerid);
					GivePlayerMoneyEx(playerid, -75);
					Server_AddMoney(75);
					//ShowItemBox(playerid, "Uang", "Received_$300", 1212, 4);
					ShowItemBox(playerid, "Uang", "Removed_$75", 1212, 4);
					InfoMsg(playerid, "Selamat kamu telah berhasil membuat SIM");
					RemovePlayerFromVehicle(playerid);
					SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					return 1;
				}
				
			}
		}
		case CHECKPOINT_BUS:
		{
			if(pData[playerid][pSideJob] == 2)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				if(GetVehicleModel(vehicleid) == 431)
				{
					if(pData[playerid][pBus] == 1)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 2;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint2, buspoint2, 5.0);
					}
					else if(pData[playerid][pBus] == 2)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 3;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint3, buspoint3, 5.0);
					}
					else if(pData[playerid][pBus] == 3)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 4;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint4, buspoint4, 5.0);
					}
					else if(pData[playerid][pBus] == 4)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 5;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint5, buspoint5, 5.0);
					}
					else if(pData[playerid][pBus] == 5)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 6;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint6, buspoint6, 5.0);
					}
					else if(pData[playerid][pBus] == 6)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 7;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint7, buspoint7, 5.0);
					}
					else if(pData[playerid][pBus] == 7)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 8;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint8, buspoint8, 5.0);
					}
					else if(pData[playerid][pBus] == 8)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 9;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint9, buspoint9, 5.0);
					}
					else if(pData[playerid][pBus] == 9)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 10;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint10, buspoint10, 5.0);
					}
					else if(pData[playerid][pBus] == 10)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 11;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint11, buspoint11, 5.0);
					}
					else if(pData[playerid][pBus] == 11)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 12;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint12, buspoint12, 5.0);
					}
					else if(pData[playerid][pBus] == 12)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 13;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint13, buspoint13, 5.0);
					}
					else if(pData[playerid][pBus] == 13)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 14;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint14, buspoint14, 5.0);
					}
					else if(pData[playerid][pBus] == 14)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 15;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint15, buspoint15, 5.0);
					}
					else if(pData[playerid][pBus] == 15)
					{
						pData[playerid][pBuswaiting] = true;
						pData[playerid][pBustime] = 10;
						PlayerPlaySound(playerid, 43000, 1965.075073,-1779.868530,13.479113);
					}
					else if(pData[playerid][pBus] == 16)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 17;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint17, buspoint17, 5.0);
					}
					else if(pData[playerid][pBus] == 17)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 18;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint18, buspoint18, 5.0);
					}
					else if(pData[playerid][pBus] == 18)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 19;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint19, buspoint19, 5.0);
					}
					else if(pData[playerid][pBus] == 19)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 20;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint20, buspoint20, 5.0);
					}
					else if(pData[playerid][pBus] == 20)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 21;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint21, buspoint21, 5.0);
					}
					else if(pData[playerid][pBus] == 21)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 22;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint22, buspoint22, 5.0);
					}
					else if(pData[playerid][pBus] == 22)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 23;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint23, buspoint23, 5.0);
					}
					else if(pData[playerid][pBus] == 23)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 24;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint24, buspoint24, 5.0);
					}
					else if(pData[playerid][pBus] == 24)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 25;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint25, buspoint25, 5.0);
					}
					else if(pData[playerid][pBus] == 25)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 26;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint26, buspoint26, 5.0);
					}
					else if(pData[playerid][pBus] == 26)
					{
						pData[playerid][pBuswaiting] = true;
						pData[playerid][pBustime] = 10;
						PlayerPlaySound(playerid, 43000, 2763.975097,-2479.834228,13.575368);
					}
					else if(pData[playerid][pBus] == 27)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 28;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint28, buspoint28, 5.0);
					}
					else if(pData[playerid][pBus] == 28)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 29;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint29, buspoint29, 5.0);
					}
					else if(pData[playerid][pBus] == 29)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 30;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint30, buspoint30, 5.0);
					}
					else if(pData[playerid][pBus] == 30)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 31;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint31, buspoint31, 5.0);
					}
					else if(pData[playerid][pBus] == 31)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 32;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint32, buspoint32, 5.0);
					}
					else if(pData[playerid][pBus] == 32)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 33;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint33, buspoint33, 5.0);
					}
					else if(pData[playerid][pBus] == 33)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 34;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint34, buspoint34, 5.0);
					}
					else if(pData[playerid][pBus] == 34)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 35;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint35, buspoint35, 5.0);
					}
					else if(pData[playerid][pBus] == 35)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 36;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint36, buspoint36, 5.0);
					}
					else if(pData[playerid][pBus] == 36)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 37;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint37, buspoint37, 5.0);
					}
					else if(pData[playerid][pBus] == 37)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 38;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint38, buspoint38, 5.0);
					}
					else if(pData[playerid][pBus] == 38)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 39;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint39, buspoint39, 5.0);
					}
					else if(pData[playerid][pBus] == 39)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 40;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint40, buspoint40, 5.0);
					}
					else if(pData[playerid][pBus] == 40)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 41;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint41, buspoint41, 5.0);
					}
					else if(pData[playerid][pBus] == 41)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 42;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint42, buspoint42, 5.0);
					}
					else if(pData[playerid][pBus] == 42)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 43;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint43, buspoint43, 5.0);
					}
					else if(pData[playerid][pBus] == 43)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 44;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint44, buspoint44, 5.0);
					}
					else if(pData[playerid][pBus] == 44)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 45;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint45, buspoint45, 5.0);
					}
					else if(pData[playerid][pBus] == 45)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 46;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint46, buspoint46, 5.0);
					}
					else if(pData[playerid][pBus] == 46)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 47;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint47, buspoint47, 5.0);
					}
					else if(pData[playerid][pBus] == 47)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 48;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint48, buspoint48, 5.0);
					}
					else if(pData[playerid][pBus] == 48)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 49;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint49, buspoint49, 5.0);
					}
					else if(pData[playerid][pBus] == 49)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 50;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint50, buspoint50, 5.0);
					}
					else if(pData[playerid][pBus] == 50)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 51;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint51, buspoint51, 5.0);
					}
					else if(pData[playerid][pBus] == 51)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 52;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint52, buspoint52, 5.0);
					}
					else if(pData[playerid][pBus] == 52)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 53;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint53, buspoint53, 5.0);
					}
					else if(pData[playerid][pBus] == 53)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 54;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint54, buspoint54, 5.0);
					}
					else if(pData[playerid][pBus] == 54)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 55;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint55, buspoint55, 5.0);
					}
					else if(pData[playerid][pBus] == 55)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 56;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint56, buspoint56, 5.0);
					}
					else if(pData[playerid][pBus] == 56)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 57;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint57, buspoint57, 5.0);
					}
					else if(pData[playerid][pBus] == 57)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 58;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint58, buspoint58, 5.0);
					}
					else if(pData[playerid][pBus] == 58)
					{
						pData[playerid][pBuswaiting] = true;
						pData[playerid][pBustime] = 10;
						PlayerPlaySound(playerid, 43000, 1235.685913,-1855.510986,13.481544);
					}
					else if(pData[playerid][pBus] == 59)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 60;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint60, buspoint60, 5.0);
					}
					else if(pData[playerid][pBus] == 60)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 61;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint61, buspoint61, 5.0);
					}
					else if(pData[playerid][pBus] == 61)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 62;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint62, buspoint62, 5.0);
					}
					else if(pData[playerid][pBus] == 62)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 63;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint63, buspoint63, 5.0);
					}
					else if(pData[playerid][pBus] == 63)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 64;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint64, buspoint64, 5.0);
					}
					else if(pData[playerid][pBus] == 64)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 65;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint65, buspoint65, 5.0);
					}
					else if(pData[playerid][pBus] == 65)
					{
						pData[playerid][pBus] = 0;
						pData[playerid][pSideJob] = 0;
						pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
						DisablePlayerRaceCheckpoint(playerid);
						AddPlayerSalary(playerid, "SideJob (Bus)", 500);
						InfoMsg(playerid, "SideJob(Bus) telah masuk ke pending salary anda!");						
					    // GivePlayerMoneyEx(playerid, 500);
					    // ShowItemBox(playerid, "Uang", "Received_$500", 1212, 4);
						RemovePlayerFromVehicle(playerid);
						SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					}
					else if(pData[playerid][pBus] == 28)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 29;
						SetPlayerRaceCheckpoint(playerid, 2, cpbus3, cpbus3, 5.0);
					}
					else if(pData[playerid][pBus] == 29)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 30;
						SetPlayerRaceCheckpoint(playerid, 2, cpbus4, cpbus4, 5.0);
					}
					else if(pData[playerid][pBus] == 30)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 31;
						SetPlayerRaceCheckpoint(playerid, 2, cpbus5, cpbus5, 5.0);
					}
					else if(pData[playerid][pBus] == 31)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 32;
						SetPlayerRaceCheckpoint(playerid, 2, cpbus6, cpbus6, 5.0);
					}
					else if(pData[playerid][pBus] == 32)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 33;
						SetPlayerRaceCheckpoint(playerid, 2, cpbus7, cpbus7, 5.0);
					}
					else if(pData[playerid][pBus] == 33)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 34;
						SetPlayerRaceCheckpoint(playerid, 2, cpbus8, cpbus8, 5.0);
					}
					else if(pData[playerid][pBus] == 34)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 35;
						SetPlayerRaceCheckpoint(playerid, 1, cpbus9, cpbus9, 5.0);
					}
					else if(pData[playerid][pBus] == 35)
					{
						pData[playerid][pBus] = 0;
						pData[playerid][pSideJob] = 0;
						pData[playerid][pBusTime] = 400;
						pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
						DisablePlayerRaceCheckpoint(playerid);
						AddPlayerSalary(playerid, "SideJob (Bus)", 100);
						InfoMsg(playerid, "SideJob(Bus) telah masuk ke pending salary anda!");					
						// ShowItemBox(playerid, "Uang", "Received_100x", 1212, 2);
						// GivePlayerMoneyEx(playerid, 100);
						RemovePlayerFromVehicle(playerid);
   						SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					}
				}
			}
		}
		case CHECKPOINT_MISC:
		{
			pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
			DisablePlayerRaceCheckpoint(playerid);
		}	
		case CHECKPOINT_SWEEPER:
		{
			if(pData[playerid][pSideJob] == 1)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				if(GetVehicleModel(vehicleid) == 574)
				{
					if(pData[playerid][pSweeper] == 1)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 2;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint2, sweperpoint2, 5.0);
					}
					else if(pData[playerid][pSweeper] == 2)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 3;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint3, sweperpoint3, 5.0);
					}
					else if(pData[playerid][pSweeper] == 3)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 4;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint4, sweperpoint4, 5.0);
					}
					else if(pData[playerid][pSweeper] == 4)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 5;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint5, sweperpoint5, 5.0);
					}
					else if(pData[playerid][pSweeper] == 5)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 6;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint6, sweperpoint6, 5.0);
					}
					else if(pData[playerid][pSweeper] == 6)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 7;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint7, sweperpoint7, 5.0);
					}
					else if(pData[playerid][pSweeper] == 7)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 8;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint8, sweperpoint8, 5.0);
					}
					else if(pData[playerid][pSweeper] == 8)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 9;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint9, sweperpoint9, 5.0);
					}
					else if(pData[playerid][pSweeper] == 9)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 10;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint10, sweperpoint10, 5.0);
					}
					else if(pData[playerid][pSweeper] == 10)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 11;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint11, sweperpoint11, 5.0);
					}
					else if(pData[playerid][pSweeper] == 11)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 12;
						SetPlayerRaceCheckpoint(playerid, 1, sweperpoint12, sweperpoint12, 5.0);
					}
					else if(pData[playerid][pSweeper] == 12)
					{
						pData[playerid][pSweeper] = 0;
						pData[playerid][pSideJob] = 0;
						pData[playerid][pSweeperTime] = 120;
						pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
						DisablePlayerRaceCheckpoint(playerid);
						AddPlayerSalary(playerid, "SideJob (Sweeper)", 200);
						InfoMsg(playerid, "SideJob(Sweeper) telah masuk ke pending salary anda!");					
						// ShowItemBox(playerid, "Uang", "Received_250x", 1212, 2);
						// GivePlayerMoneyEx(playerid, 250);
						RemovePlayerFromVehicle(playerid);
						SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					}
					else if(pData[playerid][pSweeper] == 13)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 14;
						SetPlayerRaceCheckpoint(playerid, 2, cpswep3, cpswep3, 5.0);
					}
					else if(pData[playerid][pSweeper] == 14)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 15;
						SetPlayerRaceCheckpoint(playerid, 2, cpswep4, cpswep4, 5.0);
					}
					else if(pData[playerid][pSweeper] == 15)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 16;
						SetPlayerRaceCheckpoint(playerid, 2, cpswep5, cpswep5, 5.0);
					}
					else if(pData[playerid][pSweeper] == 16)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 17;
						SetPlayerRaceCheckpoint(playerid, 2, cpswep6, cpswep6, 5.0);
					}
					else if(pData[playerid][pSweeper] == 17)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 18;
						SetPlayerRaceCheckpoint(playerid, 2, cpswep7, cpswep7, 5.0);
					}
					else if(pData[playerid][pSweeper] == 18)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 19;
						SetPlayerRaceCheckpoint(playerid, 2, cpswep8, cpswep8, 5.0);
					}
					else if(pData[playerid][pSweeper] == 19)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 20;
						SetPlayerRaceCheckpoint(playerid, 1, cpswep9, cpswep9, 5.0);
					}
					else if(pData[playerid][pSweeper] == 20)
					{
						pData[playerid][pSweeper] = 0;
						pData[playerid][pSideJob] = 0;
						pData[playerid][pSweeperTime] = 150;
						pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
						DisablePlayerRaceCheckpoint(playerid);
						AddPlayerSalary(playerid, "SideJob (Sweeper)", 100);
						InfoMsg(playerid, "SideJob(Sweeper) telah masuk ke pending salary anda!");						
						// ShowItemBox(playerid, "Uang", "Received_100x", 1212, 2);
						// GivePlayerMoneyEx(playerid, 100);
						RemovePlayerFromVehicle(playerid);
						SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					}
				}
			}
		}
		case CHECKPOINT_STREAK:
		{
			if(pData[playerid][pSideJob] == 5)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				if(GetVehicleModel(vehicleid) == 538)
				{
					if(pData[playerid][pStreak] == 1)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pStreak] = 2;
						SetPlayerRaceCheckpoint(playerid, 2, streakpoint2, streakpoint2, 5.0);
					}
					else if(pData[playerid][pStreak] == 2)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pStreak] = 3;
						SetPlayerRaceCheckpoint(playerid, 2, streakpoint3, streakpoint3, 5.0);
					}
					else if(pData[playerid][pStreak] == 3)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pStreak] = 4;
						SetPlayerRaceCheckpoint(playerid, 2, streakpoint4, streakpoint4, 5.0);
					}
					else if(pData[playerid][pStreak] == 4)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pStreak] = 5;
						SetPlayerRaceCheckpoint(playerid, 2, streakpoint5, streakpoint5, 5.0);
					}
					else if(pData[playerid][pStreak] == 5)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pStreak] = 6;
						SetPlayerRaceCheckpoint(playerid, 2, streakpoint6, streakpoint6, 5.0);
					}
					else if(pData[playerid][pStreak] == 6)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pStreak] = 7;
						SetPlayerRaceCheckpoint(playerid, 2, streakpoint7, streakpoint7, 5.0);
					}
					else if(pData[playerid][pStreak] == 7)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pStreak] = 8;
						SetPlayerRaceCheckpoint(playerid, 2, streakpoint8, streakpoint8, 5.0);
					}
					else if(pData[playerid][pStreak] == 8)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pStreak] = 9;
						SetPlayerRaceCheckpoint(playerid, 2, streakpoint9, streakpoint9, 5.0);
					}
					else if(pData[playerid][pStreak] == 9)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pStreak] = 10;
						SetPlayerRaceCheckpoint(playerid, 2, streakpoint10, streakpoint10, 5.0);
					}
					else if(pData[playerid][pStreak] == 10)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pStreak] = 11;
						SetPlayerRaceCheckpoint(playerid, 2, streakpoint11, streakpoint11, 5.0);
					}
					else if(pData[playerid][pStreak] == 11)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pStreak] = 12;
						SetPlayerRaceCheckpoint(playerid, 1, streakpoint11, streakpoint11, 5.0);
					}
					else if(pData[playerid][pStreak] == 12)
					{
						pData[playerid][pStreak] = 0;
						pData[playerid][pSideJob] = 0;
						pData[playerid][pStreakTime] = 1000;
						pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
						DisablePlayerRaceCheckpoint(playerid);
						AddPlayerSalary(playerid, "SideJob (Train)", 1000);
						InfoMsg(playerid, "SideJob(Train) telah masuk ke pending salary anda!");					
						// ShowItemBox(playerid, "Uang", "Received_250x", 1212, 2);
						// GivePlayerMoneyEx(playerid, 250);
						RemovePlayerFromVehicle(playerid);
						SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					}
				}
			}
		}
		case CHECKPOINT_FORKLIFTER:
		{
			if(pData[playerid][pSideJob] == 3)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				if(GetVehicleModel(vehicleid) == 530)
				{
					if(pData[playerid][pForklifter] == 1)
					{
						pData[playerid][pForklifter] = 2;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterLoadStatus] = 1;
						pData[playerid][pForklifterLoad] = SetTimerEx("ForklifterLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Loading...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 2)
					{
						pData[playerid][pForklifter] = 3;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterUnLoadStatus] = 1;
						pData[playerid][pForklifterUnLoad] = SetTimerEx("ForklifterUnLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Unloaded...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 3)
					{
						pData[playerid][pForklifter] = 4;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterLoadStatus] = 1;
						pData[playerid][pForklifterLoad] = SetTimerEx("ForklifterLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Loading...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 4)
					{
						pData[playerid][pForklifter] = 5;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterUnLoadStatus] = 1;
						pData[playerid][pForklifterUnLoad] = SetTimerEx("ForklifterUnLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Unloaded...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 5)
					{
						pData[playerid][pForklifter] = 6;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterLoadStatus] = 1;
						pData[playerid][pForklifterLoad] = SetTimerEx("ForklifterLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Loading...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 6)
					{
						pData[playerid][pForklifter] = 7;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterUnLoadStatus] = 1;
						pData[playerid][pForklifterUnLoad] = SetTimerEx("ForklifterUnLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Unloaded...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 7)
					{
						pData[playerid][pForklifter] = 8;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterLoadStatus] = 1;
						pData[playerid][pForklifterLoad] = SetTimerEx("ForklifterLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Loading...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 8)
					{
						pData[playerid][pForklifter] = 9;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterUnLoadStatus] = 1;
						pData[playerid][pForklifterUnLoad] = SetTimerEx("ForklifterUnLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Unloaded...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 9)
					{
						pData[playerid][pForklifter] = 10;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterLoadStatus] = 1;
						pData[playerid][pForklifterLoad] = SetTimerEx("ForklifterLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Loading...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 10)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pForklifter] = 11;
						DestroyDynamicObject(VehicleObject[vehicleid]);
						VehicleObject[vehicleid] = INVALID_OBJECT_ID;
						SetPlayerRaceCheckpoint(playerid, 1, forpoint3, forpoint3, 4.0);
					}
					else if(pData[playerid][pForklifter] == 11)
					{
						pData[playerid][pSideJob] = 0;
						pData[playerid][pForklifterTime] = 80;
						DisablePlayerRaceCheckpoint(playerid);
						AddPlayerSalary(playerid, "SideJob (Forklifster)", 200);
						InfoMsg(playerid, "SideJob(Forklifter) telah masuk ke pending salary anda!");
						// ShowItemBox(playerid, "Uang", "Received_200x", 1212, 2);
						// GivePlayerMoneyEx(playerid, 200);
						RemovePlayerFromVehicle(playerid);
						SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
						return 1;
					}
				}
			}
		}
		case CHECKPOINT_MOWER:
		{
			if(pData[playerid][pSideJob] == 4)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				if(GetVehicleModel(vehicleid) == 572)
				{
					if(pData[playerid][pMower] == 1)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 2;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint2, mowerpoint2, 5.0);
					}
					else if(pData[playerid][pMower] == 2)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 3;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint3, mowerpoint3, 5.0);
					}
					else if(pData[playerid][pMower] == 3)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 4;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint4, mowerpoint4, 5.0);
					}
					else if(pData[playerid][pMower] == 4)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 5;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint5, mowerpoint5, 5.0);
					}
					else if(pData[playerid][pMower] == 5)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 6;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint6, mowerpoint6, 5.0);
					}
					else if(pData[playerid][pMower] == 6)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 7;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint7, mowerpoint7, 5.0);
					}
					else if(pData[playerid][pMower] == 7)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 8;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint8, mowerpoint8, 5.0);
					}
					else if(pData[playerid][pMower] == 8)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 9;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint9, mowerpoint9, 5.0);
					}
					else if(pData[playerid][pMower] == 9)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 10;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint10, mowerpoint10, 5.0);
					}
					else if(pData[playerid][pMower] == 10)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 11;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint11, mowerpoint11, 5.0);
					}
					else if(pData[playerid][pMower] == 11)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 12;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint12, mowerpoint12, 5.0);
					}
					else if(pData[playerid][pMower] == 12)
					{
						pData[playerid][pSideJob] = 0;
						pData[playerid][pMower] = 0;
						pData[playerid][pMowerTime] += 120;
						pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
						DisablePlayerRaceCheckpoint(playerid);
						AddPlayerSalary(playerid, "SideJob (Mower)", 200);
						InfoMsg(playerid, "SideJob(Mower) telah masuk ke pending salary anda!");
						// ShowItemBox(playerid, "Uang", "Received_200x", 1212, 2);
						// GivePlayerMoneyEx(playerid, 200);
						RemovePlayerFromVehicle(playerid);
						SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					}
				}
			}
		}
	}
	if(pData[playerid][pGpsActive] == 1)
	{
		pData[playerid][pGpsActive] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pTrackCar] == 1)
	{
		InfoMsg(playerid, "Anda telah berhasil menemukan kendaraan anda!");
		pData[playerid][pTrackCar] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pTrackHouse] == 1)
	{
		InfoMsg(playerid, "Anda telah berhasil menemukan rumah anda!");
		pData[playerid][pTrackHouse] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pTrackVending] == 1)
	{
		InfoMsg(playerid, "Anda telah berhasil menemukan mesin vending anda!");
		pData[playerid][pTrackVending] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pTrackBisnis] == 1)
	{
		InfoMsg(playerid, "Anda telah berhasil menemukan bisnis!");
		pData[playerid][pTrackBisnis] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pMission] > -1)
	{
		DisablePlayerRaceCheckpoint(playerid);
		InfoMsg(playerid, "/buy , /gps(My Mission) , /storeproduct.");
	}
	if(pData[playerid][pHauling] > -1)
	{
		if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
		{
			DisablePlayerRaceCheckpoint(playerid);
			InfoMsg(playerid, "'/storegas' untuk menyetor GasOilnya!");
		}
		else
		{
			if(IsPlayerInRangeOfPoint(playerid, 10.0, 335.66, 861.02, 21.01))
			{
				DisablePlayerRaceCheckpoint(playerid);
				SetPlayerCheckpoint(playerid, 336.70, 895.54, 20.40, 5.5);
				InfoMsg(playerid, "Silahkan ambil trailer dan menuju ke checkpoint!");
			}
			else
			{
				ErrorMsg(playerid, "Kamu tidak membawa Trailer Gasnya, Silahkan ambil kembali trailernnya!");
			}
		}
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	//balapan
    if(pData[playerid][pRaceIndex] != 0 && pData[playerid][pRaceWith] != INVALID_PLAYER_ID && !pData[playerid][pRaceFinish])
	{
		switch(pData[playerid][pRaceIndex])
		{
		    case 1:
		    {
			    SetRaceCP(playerid, 2, RaceData[pData[playerid][pRaceWith]][racePos2][0], RaceData[pData[playerid][pRaceWith]][racePos2][1], RaceData[pData[playerid][pRaceWith]][racePos2][2], 5.0);
				pData[playerid][pRaceIndex] = 2;
			}
			case 2:
			{
			    SetRaceCP(playerid, 2, RaceData[pData[playerid][pRaceWith]][racePos3][0], RaceData[pData[playerid][pRaceWith]][racePos3][1], RaceData[pData[playerid][pRaceWith]][racePos3][2], 5.0);
				pData[playerid][pRaceIndex] = 3;
			}
			case 3:
			{
			    SetRaceCP(playerid, 2, RaceData[pData[playerid][pRaceWith]][racePos4][0], RaceData[pData[playerid][pRaceWith]][racePos4][1], RaceData[pData[playerid][pRaceWith]][racePos4][2], 5.0);
				pData[playerid][pRaceIndex] = 4;
			}
			case 4:
			{
			    SetRaceCP(playerid, 2, RaceData[pData[playerid][pRaceWith]][racePos5][0], RaceData[pData[playerid][pRaceWith]][racePos5][1], RaceData[pData[playerid][pRaceWith]][racePos5][2], 5.0);
				pData[playerid][pRaceIndex] = 5;
			}
			case 5:
			{
			    SetRaceCP(playerid, 2, RaceData[pData[playerid][pRaceWith]][raceFinish][0], RaceData[pData[playerid][pRaceWith]][raceFinish][1], RaceData[pData[playerid][pRaceWith]][raceFinish][2], 5.0);
				pData[playerid][pRaceFinish] = 1;
			}
		}
	}
	//stealcar
	if (PlayerInfo[playerid][pWaypoint])
	{
		PlayerInfo[playerid][pWaypoint] = 0;

		DisablePlayerCheckpoint(playerid);
		PlayerTextDrawHide(playerid, Lenzgpssystem[playerid][0]);
		PlayerTextDrawHide(playerid, Lenzgpssystem[playerid][1]);
		PlayerTextDrawHide(playerid, Lenzgpssystem[playerid][2]);
		PlayerTextDrawHide(playerid, Lenzgpssystem[playerid][3]);
		PlayerTextDrawHide(playerid, Lenzgpssystem[playerid][4]);
		PlayerTextDrawHide(playerid, Lenzgpssystem[playerid][5]);
		PlayerTextDrawHide(playerid, Lenzgpssystem[playerid][6]);
		PlayerTextDrawHide(playerid, lokasigps[playerid]);
		PlayerTextDrawHide(playerid, valuegps[playerid]);
	}
	// Checkpoint Job Ambil Micin
	if (IsPlayerInRangeOfPoint(playerid, 4.0,2808.1736,-2230.7356,4.0762))
    {
        SetPlayerCheckpoint(playerid, 2825.5720,-2217.0366,6.1501, 4.0);
        ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 0, 0, 1);
		InfoTD_MSG(playerid, 3000, "Micin +1");
		RemovePlayerFromVehicle(playerid);
		pData[playerid][pMicin] += 1;
    }
    if (IsPlayerInRangeOfPoint(playerid, 4.0,2825.5720,-2217.0366,6.1501))
    {
        SetPlayerCheckpoint(playerid, 2847.6199,-2181.6360,6.4229, 4.0);
        ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 0, 0, 1);
		InfoTD_MSG(playerid, 3000, "Micin +1");
		RemovePlayerFromVehicle(playerid);
		pData[playerid][pMicin] += 1;
	}
  	if (IsPlayerInRangeOfPoint(playerid, 4.0,2847.6199,-2181.6360,6.4229))
	{
        SetPlayerCheckpoint(playerid, 2880.7322,-2160.9758,3.4194, 4.0);
        ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 0, 0, 1);
		InfoTD_MSG(playerid, 3000, "Micin +1");
		RemovePlayerFromVehicle(playerid);
		pData[playerid][pMicin] += 1;
	}
    if (IsPlayerInRangeOfPoint(playerid, 4.0,2880.7322,-2160.9758,3.4194))
    {
        SetPlayerCheckpoint(playerid, 2897.5032,-2134.2986,3.2348, 4.0);
        ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 0, 0, 1);
		InfoTD_MSG(playerid, 3000, "Micin +1");
		RemovePlayerFromVehicle(playerid);
		pData[playerid][pMicin] += 1;
    }
    if (IsPlayerInRangeOfPoint(playerid, 4.0,2897.5032,-2134.2986,3.2348))
    {
        SetPlayerCheckpoint(playerid, 2908.9009,-2125.5317,1.6027, 4.0);
        ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 0, 0, 1);
		InfoTD_MSG(playerid, 3000, "Micin +1");
		RemovePlayerFromVehicle(playerid);
		pData[playerid][pMicin] += 1;
	}
    if (IsPlayerInRangeOfPoint(playerid, 4.0,2908.9009,-2125.5317,1.6027))
    {
	    SetPlayerCheckpoint(playerid, 2910.1626,-2100.1104,1.9539, 4.0);
	    ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 0, 0, 1);
		InfoTD_MSG(playerid, 3000, "Micin +1");
		RemovePlayerFromVehicle(playerid);
		pData[playerid][pMicin] += 1;
	}
    if (IsPlayerInRangeOfPoint(playerid, 4.0,2910.1626,-2100.1104,1.9539))
    {
      	ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 0, 0, 1);
      	SetPlayerCheckpoint(playerid, 2808.1736,-2230.7356,4.0762, 1.0);
		InfoTD_MSG(playerid, 3000, "Micin +1");
		RemovePlayerFromVehicle(playerid);
		pData[playerid][pMicin] += 1;
		InfoMsg(playerid, "Anda Berhasil Mengumpulkan Micin Sebanyak 7 Buah!");
    }	
	// End Checkpoint Job Micin
	if(pData[playerid][pHauling] > -1)
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.5, 336.70, 895.54, 20.40))
		{
			DisablePlayerCheckpoint(playerid);
			InfoMsg(playerid, "/buy, /gps(My Hauling), /storegas.");
		}
	}
    if(SedangAnterPizza[playerid] == 1) // pizza
	{
        SedangAnterPizza[playerid] = 0;
	    pData[playerid][pPizzaTime] = 180;
		AddPlayerSalary(playerid, "SideJob (Pizza)", 200);
		InfoMsg(playerid, "SideJob(Pizza) telah masuk ke pending salary anda!");		
		ShowItemBox(playerid, "Uang", "Received_200x", 1212, 2);
		// GivePlayerMoneyEx(playerid, 200);

    	RemovePlayerAttachedObject(playerid,1);
   		SendClientMessage(playerid,COLOR_BLUE, "PIZZA JOB: {ffffff}Kamu berhasil mengirimkan pizza dan mendapat delay 3 menit.");
        DisablePlayerCheckpoint(playerid);
	}
	if(pData[playerid][pFindEms] != INVALID_PLAYER_ID)
	{
		pData[playerid][pFindEms] = INVALID_PLAYER_ID;
		DisablePlayerCheckpoint(playerid);
	}
	if(pData[playerid][pSideJob] == 1)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 574)
		{
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint1))
			{
				SetPlayerCheckpoint(playerid, sweperpoint2, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint2))
			{
				SetPlayerCheckpoint(playerid, sweperpoint3, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint3))
			{
				SetPlayerCheckpoint(playerid, sweperpoint4, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint4))
			{
				SetPlayerCheckpoint(playerid, sweperpoint5, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint5))
			{
				SetPlayerCheckpoint(playerid, sweperpoint6, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint6))
			{
				SetPlayerCheckpoint(playerid, sweperpoint7, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint7))
			{
				SetPlayerCheckpoint(playerid, sweperpoint8, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint8))
			{
				SetPlayerCheckpoint(playerid, sweperpoint9, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint9))
			{
				SetPlayerCheckpoint(playerid, sweperpoint10, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint10))
			{
				SetPlayerCheckpoint(playerid, sweperpoint11, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint11))
			{
				SetPlayerCheckpoint(playerid, sweperpoint12, 7.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint12))
			{
				pData[playerid][pSideJob] = 0;
				pData[playerid][pSweeperTime] = 120;
				DisablePlayerCheckpoint(playerid);
				// ShowItemBox(playerid, "Uang", "Received_300x", 1212, 2);
				AddPlayerSalary(playerid, "SideJob (Sweeper)", 300);
				InfoMsg(playerid, "SideJob(Sweeper) telah masuk ke pending salary anda!");
				// GivePlayerMoneyEx(playerid, 300);
				RemovePlayerFromVehicle(playerid);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			}
		}
	}
	if(pData[playerid][pSideJob] == 5)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 538)
		{
			if (IsPlayerInRangeOfPoint(playerid, 7.0,streakpoint1))
			{
				SetPlayerCheckpoint(playerid, streakpoint2, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,streakpoint2))
			{
				SetPlayerCheckpoint(playerid, streakpoint3, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,streakpoint3))
			{
				SetPlayerCheckpoint(playerid, streakpoint4, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,streakpoint4))
			{
				SetPlayerCheckpoint(playerid, streakpoint5, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,streakpoint5))
			{
				SetPlayerCheckpoint(playerid, streakpoint6, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,streakpoint6))
			{
				SetPlayerCheckpoint(playerid, streakpoint7, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,streakpoint7))
			{
				SetPlayerCheckpoint(playerid, streakpoint8, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,streakpoint8))
			{
				SetPlayerCheckpoint(playerid, streakpoint9, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,streakpoint9))
			{
				SetPlayerCheckpoint(playerid, streakpoint10, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,streakpoint10))
			{
				SetPlayerCheckpoint(playerid, streakpoint11, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,streakpoint11))
			{
				SetPlayerCheckpoint(playerid, streakpoint12, 7.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 7.0,streakpoint12))
			{
				pData[playerid][pSideJob] = 0;
				pData[playerid][pStreakTime] = 1000;
				DisablePlayerCheckpoint(playerid);
				// ShowItemBox(playerid, "Uang", "Received_300x", 1212, 2);
				AddPlayerSalary(playerid, "SideJob (Train)", 1000);
				InfoMsg(playerid, "SideJob(Train) telah masuk ke pending salary anda!");
				// GivePlayerMoneyEx(playerid, 300);
				RemovePlayerFromVehicle(playerid);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			}
		}
	}
	if(pData[playerid][pSideJob] == 2)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 431)
		{
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint1))
			{
				SetPlayerCheckpoint(playerid, buspoint2, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint2))
			{
				SetPlayerCheckpoint(playerid, buspoint3, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint3))
			{
				SetPlayerCheckpoint(playerid, buspoint4, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint4))
			{
				SetPlayerCheckpoint(playerid, buspoint5, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint5))
			{
				SetPlayerCheckpoint(playerid, buspoint6, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint6))
			{
				SetPlayerCheckpoint(playerid, buspoint7, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint7))
			{
				SetPlayerCheckpoint(playerid, buspoint8, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint8))
			{
				SetPlayerCheckpoint(playerid, buspoint9, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint9))
			{
				SetPlayerCheckpoint(playerid, buspoint10, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint10))
			{
				SetPlayerCheckpoint(playerid, buspoint11, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint11))
			{
				SetPlayerCheckpoint(playerid, buspoint12, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint12))
			{
				SetPlayerCheckpoint(playerid, buspoint13, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint13))
			{
				SetPlayerCheckpoint(playerid, buspoint14, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint14))
			{
				SetPlayerCheckpoint(playerid, buspoint15, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint15))
			{
				SetPlayerCheckpoint(playerid, buspoint16, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint16))
			{
				SetPlayerCheckpoint(playerid, buspoint17, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint17))
			{
				SetPlayerCheckpoint(playerid, buspoint18, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint18))
			{
				SetPlayerCheckpoint(playerid, buspoint19, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint19))
			{
				SetPlayerCheckpoint(playerid, buspoint20, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint20))
			{
				SetPlayerCheckpoint(playerid, buspoint21, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint21))
			{
				SetPlayerCheckpoint(playerid, buspoint22, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint22))
			{
				SetPlayerCheckpoint(playerid, buspoint23, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint23))
			{
				SetPlayerCheckpoint(playerid, buspoint24, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint24))
			{
				SetPlayerCheckpoint(playerid, buspoint25, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint25))
			{
				SetPlayerCheckpoint(playerid, buspoint26, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint26))
			{
				SetPlayerCheckpoint(playerid, buspoint27, 7.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 7.0,buspoint27))
			{
				pData[playerid][pSideJob] = 0;
				pData[playerid][pBusTime] = 280;
				DisablePlayerCheckpoint(playerid);
				ShowItemBox(playerid, "Uang", "Received_300x", 1212, 2);
				AddPlayerSalary(playerid, "SideJob (Bus)", 300);
				// GivePlayerMoneyEx(playerid, 300);
				RemovePlayerFromVehicle(playerid);
				// DestroyVehicle(BusVeh[0]);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			}
		}
	}
	//DisablePlayerCheckpoint(playerid);
	return 1;
}
forward EnterBisnis(playerid);
forward EnterHouse(playerid);
forward EnterDoor(playerid);
forward JobForklift(playerid);
public JobForklift(playerid)
{
	TogglePlayerControllable(playerid, true);
	GameTextForPlayer(playerid, "~w~SELESAI!", 5000, 3);
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)

{
	//RADIAL TRY
	if((newkeys & KEY_NO))
	{
	    if(pData[playerid][pProgress] == 1) return ErrorMsg(playerid, "Anda sedang melakukan sesuatu, tunggu sampai progress selesai!!");
		Servers(playerid, "Gunakan {FFFF00}'/cursor'{FFFFFF} jika cursor menghilang / textdraw tidak dapat ditekan");
		for(new i = 0; i < 104; i++)
		{
			PlayerTextDrawShow(playerid, TRYRADIAL[playerid][i]);
		}
		PlayerTextDrawShow(playerid, C_Car[playerid]);
		PlayerTextDrawShow(playerid, C_Inv[playerid]);
		PlayerTextDrawShow(playerid, C_hp[playerid]);
		PlayerTextDrawShow(playerid, C_dokumen[playerid]);
		PlayerTextDrawShow(playerid, C_aksi[playerid]);
		PlayerTextDrawShow(playerid, C_Aksesoris[playerid]);
		PlayerTextDrawShow(playerid, C_ClosePanel[playerid]);
		SelectTextDraw(playerid, -1);
	}
    // Menguji apakah tombol "H" ditekan
    if (PRESSED(KEY_CTRL_BACK))
    {
        // Eksekusi command astop
        return callcmd::astop(playerid, "");
    }
	if (newkeys & KEY_SUBMISSION) // Eksekusi untuk membuka tutup mobil dengan angka 2
	{
        if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
            callcmd::lock(playerid, "");
        }
    }
    if(newkeys & KEY_WALK)
    {
    	if(IsPlayerInRangeOfPoint(playerid, 6.0, 1023.9856,-295.5638,73.9931))
    	{
    		callcmd::ambilayam(playerid, "");
    	}
    	if(IsPlayerInRangeOfPoint(playerid, 7.0, 1021.1126,-307.9776,77.3594))
    	{
    		callcmd::packingayam(playerid, "");
    	}
    	if(IsPlayerInRangeOfPoint(playerid, 3.0, 1021.0649,-290.3679,77.3594))
    	{
    		callcmd::potongayam(playerid, "");
    	}
    }
    if(newkeys & KEY_WALK)
    {
    	if(IsPlayerInRangeOfPoint(playerid, 2.0, 1548.7379,-40.0872,21.2479))
    	{
    		callcmd::ambilmarkisa(playerid, "");
    	}
    }
	if(newkeys & KEY_WALK)
    {
    	if(IsPlayerInRangeOfPoint(playerid, 2.0, 1548.4639,-46.6194,21.1046))
    	{
    		callcmd::ambilmarkisa(playerid, "");
    	}
    }
	if(newkeys & KEY_WALK)
    {
    	if(IsPlayerInRangeOfPoint(playerid, 2.0, 1548.1360,-57.9056,20.9540))
    	{
    		callcmd::ambilmarkisa(playerid, "");
    	}
    }
	if(newkeys & KEY_WALK)
    {
    	if(IsPlayerInRangeOfPoint(playerid, 2.0, 1548.2399,-51.9364,21.0124))
    	{
    		callcmd::ambilmarkisa(playerid, "");
    	}
    }
    if(newkeys & KEY_WALK)
    {
    	if(IsPlayerInRangeOfPoint(playerid, 2.0, 1553.2319,-33.3558,21.3640))
    	{
    		callcmd::prosesmarkisa(playerid, "");
    	}
    }
	if(newkeys & KEY_WALK)
    {
    	if(IsPlayerInRangeOfPoint(playerid, 2.0, 1551.2854,-33.3567,21.3450))
    	{
    		callcmd::prosesmarkisa(playerid, "");
    	}
    }
	if(newkeys & KEY_WALK)
    {
    	if(IsPlayerInRangeOfPoint(playerid, 2.0,  1548.6514,-33.3587,21.3192))
    	{
    		callcmd::prosesmarkisa(playerid, "");
    	}
    }
	if(newkeys & KEY_WALK)
    {
    	if(IsPlayerInRangeOfPoint(playerid, 2.0, 1546.8285,-33.3583,21.3014))
    	{
    		callcmd::prosesmarkisa(playerid, "");
    	}
    }
	if(newkeys & KEY_WALK)
    {
    	if(IsPlayerInRangeOfPoint(playerid, 2.0, 1392.5824,-14.8366,1000.9166))
    	{
    		callcmd::paytax(playerid, "");
    	}
    }

	//rokok
	if(newkeys & KEY_FIRE && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_SMOKE_CIGGY)
	{
    	if(GetPVarInt(playerid, "ngudud") > gettime())
        	return ErrorMsg(playerid, "Mohon Tunggu 5 Detik (Don't Spam).");

		SendClientMessageEx(playerid, ARWIN,"USE: "WHITE_E"Anda telah berhasil merokok.");
		SetTimerEx("CigarStop", 1000, 0, "i", playerid);

		StartPlayerLoadingBar(playerid, 3, "Ngudud...");
			//pData[playerid][pBandage] = gettime() + 10;
		new Float:darah;
		GetPlayerHealth(playerid, darah);
		pData[playerid][pRokok]--;

		if(pData[playerid][pBladder] > 0)
			return ErrorMsg(playerid, "Anda Sudah Relax."), SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

		//SetPlayerHealthEx(playerid, darah+5);
		pData[playerid][pBladder] -= 10;
		SetPVarInt(playerid, "ngudud", gettime() + 5);
 	}
	if((newkeys & KEY_FIRE))
	{
		//anti boren by van
		if(GetPlayerWeapon(playerid) == 22)
		{
			if(pData[playerid][pCharacterStory] == 0)
	    	{
	    		SendClientMessage(playerid, -1, "{FF0000}[System] {FFFF00}Anda tidak memiliki {FF0000}Character Story{FFFF00}, Dan senjata anda Telah Di Reset otomatis");
	    		ResetWeapon(playerid, 22);
	    	}
		}
		if(GetPlayerWeapon(playerid) == 23)
		{
			if(pData[playerid][pCharacterStory] == 0)
	    	{
	    		SendClientMessage(playerid, -1, "{FF0000}[System] {FFFF00}Anda tidak memiliki {FF0000}Character Story{FFFF00}, Dan senjata anda Telah Di Reset otomatis");
	    		ResetWeapon(playerid, 23);
	    	}
		}
		if(GetPlayerWeapon(playerid) == 25)
		{
			if(pData[playerid][pCharacterStory] == 0)
	    	{
	    		SendClientMessage(playerid, -1, "{FF0000}[System] {FFFF00}Anda tidak memiliki {FF0000}Character Story{FFFF00}, Dan senjata anda Telah Di Reset otomatis");
	    		ResetWeapon(playerid, 25);
	    	} 
		}
		if(GetPlayerWeapon(playerid) == 26)
		{
			if(pData[playerid][pCharacterStory] == 0)
	    	{
	    		SendClientMessage(playerid, -1, "{FF0000}[System] {FFFF00}Anda tidak memiliki {FF0000}Character Story{FFFF00}, Dan senjata anda Telah Di Reset otomatis");
	    		ResetWeapon(playerid, 26);
	    	}
		}
		if(GetPlayerWeapon(playerid) == 27)
		{
			if(pData[playerid][pCharacterStory] == 0)
	    	{
	    		SendClientMessage(playerid, -1, "{FF0000}[System] {FFFF00}Anda tidak memiliki {FF0000}Character Story{FFFF00}, Dan senjata anda Telah Di Reset otomatis");
	    		ResetWeapon(playerid, 27);
	    	}
		}
		if(GetPlayerWeapon(playerid) == 28)
		{
			if(pData[playerid][pCharacterStory] == 0)
	    	{
	    		SendClientMessage(playerid, -1, "{FF0000}[System] {FFFF00}Anda tidak memiliki {FF0000}Character Story{FFFF00}, Dan senjata anda Telah Di Reset otomatis");
	    		ResetWeapon(playerid, 28);
	    	}
		}
		if(GetPlayerWeapon(playerid) == 29)
		{
			if(pData[playerid][pCharacterStory] == 0)
	    	{
	    		SendClientMessage(playerid, -1, "{FF0000}[System] {FFFF00}Anda tidak memiliki {FF0000}Character Story{FFFF00}, Dan senjata anda Telah Di Reset otomatis");
	    		ResetWeapon(playerid, 29);
	    	}
		}
		if(GetPlayerWeapon(playerid) == 32)
		{
			if(pData[playerid][pCharacterStory] == 0)
	    	{
	    		SendClientMessage(playerid, -1, "{FF0000}[System] {FFFF00}Anda tidak memiliki {FF0000}Character Story{FFFF00}, Dan senjata anda Telah Di Reset otomatis");
	    		ResetWeapon(playerid, 32);
	    	}
		}
		if(GetPlayerWeapon(playerid) == 33)
		{
			if(pData[playerid][pCharacterStory] == 0)
	    	{
	    		SendClientMessage(playerid, -1, "{FF0000}[System] {FFFF00}Anda tidak memiliki {FF0000}Character Story{FFFF00}, Dan senjata anda Telah Di Reset otomatis");
	    		ResetWeapon(playerid, 33);
	    	}
		}
		if(GetPlayerWeapon(playerid) == 34)
		{
			if(pData[playerid][pCharacterStory] == 0)
	    	{
	    		SendClientMessage(playerid, -1, "{FF0000}[System] {FFFF00}Anda tidak memiliki {FF0000}Character Story{FFFF00}, Dan senjata anda Telah Di Reset otomatis");
	    		ResetWeapon(playerid, 34);
	    	}
		}
		if(GetPlayerWeapon(playerid) == 35)
		{
			if(pData[playerid][pCharacterStory] == 0)
	    	{
	    		SendClientMessage(playerid, -1, "{FF0000}[System] {FFFF00}Anda tidak memiliki {FF0000}Character Story{FFFF00}, Dan senjata anda Telah Di Reset otomatis");
	    		ResetWeapon(playerid, 35);
	    	}
		}
		if(GetPlayerWeapon(playerid) == 36)
		{
			if(pData[playerid][pCharacterStory] == 0)
	    	{
	    		SendClientMessage(playerid, -1, "{FF0000}[System] {FFFF00}Anda tidak memiliki {FF0000}Character Story{FFFF00}, Dan senjata anda Telah Di Reset otomatis");
	    		ResetWeapon(playerid, 36);
	    	}
		}
		if(GetPlayerWeapon(playerid) == 37)
		{
			if(pData[playerid][pCharacterStory] == 0)
	    	{
	    		SendClientMessage(playerid, -1, "{FF0000}[System] {FFFF00}Anda tidak memiliki {FF0000}Character Story{FFFF00}, Dan senjata anda Telah Di Reset otomatis");
	    		ResetWeapon(playerid, 37);
	    	}
		}
		if(GetPlayerWeapon(playerid) == 38)
		{
			if(pData[playerid][pCharacterStory] == 0)
	    	{
	    		SendClientMessage(playerid, -1, "{FF0000}[System] {FFFF00}Anda tidak memiliki {FF0000}Character Story{FFFF00}, Dan senjata anda Telah Di Reset otomatis");
	    		ResetWeapon(playerid, 38);
	    	}
		}
		if(GetPlayerWeapon(playerid) == 39)
		{
			if(pData[playerid][pCharacterStory] == 0)
	    	{
	    		SendClientMessage(playerid, -1, "{FF0000}[System] {FFFF00}Anda tidak memiliki {FF0000}Character Story{FFFF00}, Dan senjata anda Telah Di Reset otomatis");
	    		ResetWeapon(playerid, 39);
	    	}
		}
		if(GetPlayerWeapon(playerid) == 40)
		{
			if(pData[playerid][pCharacterStory] == 0)
	    	{
	    		SendClientMessage(playerid, -1, "{FF0000}[System] {FFFF00}Anda tidak memiliki {FF0000}Character Story{FFFF00}, Dan senjata anda Telah Di Reset otomatis");
	    		ResetWeapon(playerid, 40);
	    	}
		}
	    if(GetPlayerWeapon(playerid) == 24)
	    {
	    	if(pData[playerid][pCharacterStory] == 0)
	    	{
	    		SendClientMessage(playerid, -1, "{FF0000}[System] {FFFF00}Anda tidak memiliki {FF0000}Character Story{FFFF00}, Dan senjata anda Telah Di Reset otomatis");
	    		ResetWeapon(playerid, 24);
	    	}
		    if(GetPlayerAmmo(playerid) == 0)
			{
			    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Peluru Habis", "Peluru habis silahkan reload?!", "Close", "");
                GivePlayerWeaponEx(playerid, 24, 1);
			}
		}
		if(GetPlayerWeapon(playerid) == 30)
	    {
		    if(GetPlayerAmmo(playerid) == 0)
			{
			    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Peluru Habis", "Peluru habis silahkan reload?!", "Close", "");
                GivePlayerWeaponEx(playerid, 30, 1);
			}
		}
		if(GetPlayerWeapon(playerid) == 31)
	    {
		    if(GetPlayerAmmo(playerid) == 0)
			{
			    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Peluru Habis", "Peluru habis silahkan reload?!", "Close", "");
                GivePlayerWeaponEx(playerid, 31, 1);
			}
		}
		if(GetPlayerWeapon(playerid) == 42)
	    {
		    if(GetPlayerAmmo(playerid) == 0)
			{
				for (new i = 0; i < sizeof(g_aFireObjects); i ++)
				{
					g_aFireExtinguished[i] = 0;

					if (IsValidDynamicObject(g_aFireObjects[i]))
						DestroyDynamicObject(g_aFireObjects[i]);
				}
				SendClientMessageToAllEx(COLOR_RIKO, "[SAFD]: {FFFFFF}%s Telah Berhasil Memadamkan Api Yang Membara Bersama Teamnya.", pData[playerid][pName]);
				//ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Peluru Habis", "Peluru habis silahkan reload?!", "Close", "");
            	GivePlayerWeaponEx(playerid, 42, 1);
			}
		}
	}

    if(newkeys & KEY_CROUCH)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			foreach(new idx : Gates)
			{
				if(gData[idx][gModel] && IsPlayerInRangeOfPoint(playerid, 8.0, gData[idx][gCX], gData[idx][gCY], gData[idx][gCZ]))
				{
					if(gData[idx][gFaction] > 0)
					{
						if(gData[idx][gFaction] != pData[playerid][pFaction])
							return ErrorMsg(playerid, "This gate only for faction.");
					}
					if(gData[idx][gFamily] > -1)
					{
						if(gData[idx][gFamily] != pData[playerid][pFamily])
							return ErrorMsg(playerid, "This gate only for family.");
					}

					if(gData[idx][gVip] > pData[playerid][pVip])
						return ErrorMsg(playerid, "Your VIP level not enough to enter this gate.");

					if(gData[idx][gAdmin] > pData[playerid][pAdmin])
						return ErrorMsg(playerid, "Your admin level not enough to enter this gate.");

					if(strlen(gData[idx][gPass]))
					{
						new params[256];
						if(sscanf(params, "s[36]", params)) return SyntaxMsg(playerid, "/gate [password]");
						if(strcmp(params, gData[idx][gPass])) return ErrorMsg(playerid, "Invalid gate password.");
						if(!gData[idx][gStatus])
						{
							gData[idx][gStatus] = 1;
							MoveDynamicObject(gData[idx][gObjID], gData[idx][gOX], gData[idx][gOY], gData[idx][gOZ], gData[idx][gSpeed]);
							SetDynamicObjectRot(gData[idx][gObjID], gData[idx][gORX], gData[idx][gORY], gData[idx][gORZ]);
						}
						else
						{
							gData[idx][gStatus] = 0;
							MoveDynamicObject(gData[idx][gObjID], gData[idx][gCX], gData[idx][gCY], gData[idx][gCZ], gData[idx][gSpeed]);
							SetDynamicObjectRot(gData[idx][gObjID], gData[idx][gCRX], gData[idx][gCRY], gData[idx][gCRZ]);
						}
					}
					else
					{
						if(!gData[idx][gStatus])
						{
							gData[idx][gStatus] = 1;
							MoveDynamicObject(gData[idx][gObjID], gData[idx][gOX], gData[idx][gOY], gData[idx][gOZ], gData[idx][gSpeed]);
							SetDynamicObjectRot(gData[idx][gObjID], gData[idx][gORX], gData[idx][gORY], gData[idx][gORZ]);
						}
						else
						{
							gData[idx][gStatus] = 0;
							MoveDynamicObject(gData[idx][gObjID], gData[idx][gCX], gData[idx][gCY], gData[idx][gCZ], gData[idx][gSpeed]);
							SetDynamicObjectRot(gData[idx][gObjID], gData[idx][gCRX], gData[idx][gCRY], gData[idx][gCRZ]);
						}
					}
					return 1;
				}
			}
		}
	}
	//anticbug
	if((newkeys & (KEY_FIRE | KEY_CROUCH)) == (KEY_FIRE | KEY_CROUCH) && (oldkeys & (KEY_FIRE | KEY_CROUCH)) != (KEY_FIRE | KEY_CROUCH))
	{
		new gun = GetPlayerWeapon(playerid);
		if(gun == 24)
		{
			cbugwarn[playerid]++;
			if(cbugwarn[playerid] == 5) return Kick(playerid);
			InfoMsg(playerid, "Kamu telah menggunakan cbug, peringatan ke 5 akan ditendang!");
			TogglePlayerControllable(playerid, 0);
			SetTimerEx("UnToggle", 3000, false, "i", playerid);
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Peringatan Cbug", "Anda terdeteksi menggunakan Cbug, Peringatan ke 5 Anda akan ditendang", "Okay", "");
			return 1;
		}
	}
	//Graffity
	if(PRESSED(KEY_FIRE) && GetPlayerWeapon(playerid) == 42 )
	{
        static
	        Float:fX,
	        Float:fY,
	        Float:fZ;

		if(pData[playerid][pFaction] != 3)
        	return ErrorMsg(playerid, "Kamu harus menjadi samd officer.");

	    for (new i = 0; i < sizeof(g_aFireObjects); i ++)
	    {
			GetDynamicObjectPos(g_aFireObjects[i], fX, fY, fZ);

			if ((IsValidDynamicObject(g_aFireObjects[i]) && IsPlayerInRangeOfPoint(playerid, 10.0, fX, fY, fZ)) && ++ g_aFireExtinguished[i] == 32)
   			{
   			    SetTimerEx("DestroyWater", 1000, false, "d", CreateDynamicObject(18744, fX, fY, fZ - 0.2, 0.0, 0.0, 0.0));
				StartPlayerLoadingBar(playerid, 3, "Memadamkan...");
      			DestroyDynamicObject(g_aFireObjects[i]);
	        	g_aFireExtinguished[i] = 0;
			}
		}
	}
	//Graffity
	if(PRESSED(KEY_FIRE) && GetPVarInt(playerid, "GraffitiCreating") == 0  && GetPlayerWeapon(playerid) == 41 )
	{
		if(!IsValidDynamicObject(POBJECT[playerid]))
    	{
		    spraytimerch[playerid] = SetTimerEx( "sprayingch", 1000, true, "i", playerid );
		    SetPVarInt(playerid, "GraffitiMenu", 1);
	    	return 1;
	    }
	    return ShowPlayerDialog(playerid, DIALOG_GDOBJECT, DIALOG_STYLE_MSGBOX, "Graffiti", "Anda sudah membuat graffiti\n\nJika anda ingin melanjutkan, text sebelumnya akan terhapus.", "Oke", "Cancel");
	}
	if(RELEASED( KEY_FIRE ) && GetPVarInt(playerid, "GraffitiMenu") == 1 && GetPlayerWeapon(playerid) == 41)
	{
	    KillTimer( spraytimerch[playerid] );
	    graffmenup[playerid] = 0;
	    DeletePVar(playerid, "GraffitiMenu");
	    return 1;
	}
	if( RELEASED( KEY_FIRE ) && GetPVarInt(playerid, "GraffitiCreating") == 1 )
	{
		if(GetPlayerWeapon(playerid) == 41 )
		{
		    KillTimer( spraytimer[playerid] );
	    	sprayammount[playerid] --;
    	 	spraytimerx[playerid] = SetTimerEx( "killgr", 90000, true, "i", playerid );
		}
	}
	//pemadam
	if(PRESSED(KEY_FIRE) && GetPlayerWeapon(playerid) == 42)
	{
        static
	        Float:fX,
	        Float:fY,
	        Float:fZ;

	    for (new i = 0; i < sizeof(g_aFireObjects); i ++)
	    {
			GetDynamicObjectPos(g_aFireObjects[i], fX, fY, fZ);

			if ((IsValidDynamicObject(g_aFireObjects[i]) && IsPlayerInRangeOfPoint(playerid, 4.0, fX, fY, fZ)) && ++ g_aFireExtinguished[i] == 32)
   			{
   			    SetTimerEx("DestroyWater", 1000, false, "d", CreateDynamicObject(18744, fX, fY, fZ - 0.2, 0.0, 0.0, 0.0));

      			DestroyDynamicObject(g_aFireObjects[i]);
	        	g_aFireExtinguished[i] = 0;
			}
		}
	}
	if(PRESSED(KEY_FIRE) && (GetVehicleModel(GetPlayerVehicleID(playerid)) == 407 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 544))
	{
	    static
	        Float:fX,
	        Float:fY,
	        Float:fZ,
			Float:fVector[3],
			Float:fCamera[3];

	    GetPlayerCameraFrontVector(playerid, fVector[0], fVector[1], fVector[2]);
	    GetPlayerCameraPos(playerid, fCamera[0], fCamera[1], fCamera[2]);

	    for (new i = 0; i < sizeof(g_aFireObjects); i ++)
	    {
			GetDynamicObjectPos(g_aFireObjects[i], fX, fY, fZ);

			if (IsValidDynamicObject(g_aFireObjects[i]) && IsPlayerInRangeOfPoint(playerid, 3050, fX, fY, fZ))
			{
				if (++g_aFireExtinguished[i] == 64 && DistanceCameraTargetToLocation(fCamera[0], fCamera[1], fCamera[2], fX, fY, fZ + 2.5, fVector[0], fVector[1], fVector[2]) < 12.0)
   				{
   			    	SetTimerEx("DestroyWater", 1000, false, "d", CreateDynamicObject(18744, fX, fY, fZ - 0.2, 0.0, 0.0, 0.0));

	      			DestroyDynamicObject(g_aFireObjects[i]);
		        	g_aFireExtinguished[i] = 0;
				}
		  	}
	    }
	}


	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && (newkeys & KEY_WALK))
	{
	    if(pData[playerid][CarryingLumber])
		{
			Player_DropLumber(playerid);
		}
		else if(pData[playerid][CarryingBox])
		{
			Player_DropBox(playerid);
		}
		/*else if(pData[playerid][CarryingLog] == 0)
		{
			Player_DropLog(playerid, pData[playerid][CarryingLog]);
			InfoMsg(playerid, "You dropping metal ore.");
			DisablePlayerCheckpoint(playerid);
		}
		else if(pData[playerid][CarryingLog] == 1)
		{
			Player_DropLog(playerid, pData[playerid][CarryingLog]);
			InfoMsg(playerid, "You dropping coal ore.");
			DisablePlayerCheckpoint(playerid);
		}*/
	}
	if((newkeys & KEY_SECONDARY_ATTACK))
	{
		foreach(new vid : Vendings)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, VendingData[vid][vendingX], VendingData[vid][vendingY], VendingData[vid][vendingZ]) && strcmp(VendingData[vid][vendingOwner], "-"))
			{
				if(vid <= -1)
					return 0;

				new
					string[300];

				format(string, sizeof(string), "PotaBee\t%s\nCheetos\t%s\nSprunk\t%s\nCofee\t%s\n",
				FormatMoney(VendingData[vid][vendingItemPrice][0]),
				FormatMoney(VendingData[vid][vendingItemPrice][1]),
				FormatMoney(VendingData[vid][vendingItemPrice][2]),
			    FormatMoney(VendingData[vid][vendingItemPrice][3]));
				
				ShowPlayerDialog(playerid, DIALOG_VENDING_BUYPROD, DIALOG_STYLE_LIST, VendingData[vid][vendingName], string, "Buy", "Cancel");
				ApplyAnimation(playerid, "VENDING", "VEND_USE", 10.0, 0, 0, 0, 0, 0, 1);
				//SetTimerEx("VendingNgentot", 2000, false, "i", playerid);
			}
		}
	}
	if((newkeys & KEY_SECONDARY_ATTACK))
    {
		foreach(new did : Doors)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]))
			{
				if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
					return ErrorMsg(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

				if(dData[did][dLocked])
					return ErrorMsg(playerid, "This entrance is locked at the moment.");
					
				if(dData[did][dFaction] > 0)
				{
					if(dData[did][dFaction] != pData[playerid][pFaction])
						return ErrorMsg(playerid, "This door only for faction.");
				}
				if(dData[did][dFamily] > 0)
				{
					if(dData[did][dFamily] != pData[playerid][pFamily])
						return ErrorMsg(playerid, "This door only for family.");
				}
				
				if(dData[did][dVip] > pData[playerid][pVip])
					return ErrorMsg(playerid, "Your VIP level not enough to enter this door.");
				
				if(dData[did][dAdmin] > pData[playerid][pAdmin])
					return ErrorMsg(playerid, "Your admin level not enough to enter this door.");
					
				if(strlen(dData[did][dPass]))
				{
					new params[256];
					if(sscanf(params, "s[256]", params)) return SyntaxMsg(playerid, "/enter [password]");
					if(strcmp(params, dData[did][dPass])) return ErrorMsg(playerid, "Invalid door password.");
					
					if(dData[did][dCustom])
					{
						SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					else
					{
						SetPlayerPosition(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					//if(PlayerInfo[playerid][pProgress] == 1) return ErrorMsg(playerid, "Tunggu Sebentar");
					pData[playerid][pInDoor] = did;
					StartPlayerLoadingBar(playerid, 5, "Rendering...");
					SetPlayerInterior(playerid, dData[did][dIntint]);
					SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
					//SetCameraBehindPlayer(playerid);
					TogglePlayerControllable(playerid, 0);
					//SetTimerEx("UnToggle", 3000, false, "i", playerid);
					SetTimer("UnToggle", 1000, false);
					SetPlayerWeather(playerid, 0);
				}
				else
				{
					if(dData[did][dCustom])
					{
						SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					else
					{
						SetPlayerPosition(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					//if(PlayerInfo[playerid][pProgress] == 1) return ErrorMsg(playerid, "Tunggu Sebentar");
					pData[playerid][pInDoor] = did;
					StartPlayerLoadingBar(playerid, 5, "Rendering...");
					SetPlayerInterior(playerid, dData[did][dIntint]);
					SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
					TogglePlayerControllable(playerid, 0);
					SetTimer("UnToggle", 1000, false);
					SetPlayerWeather(playerid, 0);
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]))
			{
				if(dData[did][dFaction] > 0)
				{
					if(dData[did][dFaction] != pData[playerid][pFaction])
						return ErrorMsg(playerid, "This door only for faction.");
				}
				
				if(dData[did][dCustom])
				{
					SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
				}
				else
				{
					SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
				}
				pData[playerid][pInDoor] = -1;
				//if(PlayerInfo[playerid][pProgress] == 1) return ErrorMsg(playerid, "Tunggu Sebentar");
				StartPlayerLoadingBar(playerid, 5, "Rendering...");
				SetPlayerInterior(playerid, dData[did][dExtint]);
				SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, WorldWeather);
			}
        }

		//Bisnis
		foreach(new bid : Bisnis)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]))
			{
				if(bData[bid][bIntposX] == 0.0 && bData[bid][bIntposY] == 0.0 && bData[bid][bIntposZ] == 0.0)
					return ErrorMsg(playerid, "Interior bisnis masih kosong, atau tidak memiliki interior.");

				if(bData[bid][bLocked])
					return ErrorMsg(playerid, "This bisnis is locked!");
					
				pData[playerid][pInBiz] = bid;
				SetPlayerPositionEx(playerid, bData[bid][bIntposX], bData[bid][bIntposY], bData[bid][bIntposZ], bData[bid][bIntposA]);
				
				//PlayAudioStreamForPlayer(playerid, bData[bid][bSong], bData[bid][bIntposX], bData[bid][bIntposY], bData[bid][bIntposZ], 15.0, 1);
				SetPlayerInterior(playerid, bData[bid][bInt]);
				SetPlayerVirtualWorld(playerid, bid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
        }
		new inbisnisid = pData[playerid][pInBiz];
		if(pData[playerid][pInBiz] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, bData[inbisnisid][bIntposX], bData[inbisnisid][bIntposY], bData[inbisnisid][bIntposZ]))
		{
			pData[playerid][pInBiz] = -1;
			SetPlayerPositionEx(playerid, bData[inbisnisid][bExtposX], bData[inbisnisid][bExtposY], bData[inbisnisid][bExtposZ], bData[inbisnisid][bExtposA]);
			
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
		}
		//Houses
		foreach(new hid : Houses)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
			{
				if(hData[hid][hIntposX] == 0.0 && hData[hid][hIntposY] == 0.0 && hData[hid][hIntposZ] == 0.0)
					return ErrorMsg(playerid, "Interior house masih kosong, atau tidak memiliki interior.");

				if(hData[hid][hLocked])
					return ErrorMsg(playerid, "This house is locked!");
				
				pData[playerid][pInHouse] = hid;
				SetPlayerPositionEx(playerid, hData[hid][hIntposX], hData[hid][hIntposY], hData[hid][hIntposZ], hData[hid][hIntposA]);

				SetPlayerInterior(playerid, hData[hid][hInt]);
				SetPlayerVirtualWorld(playerid, hid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
        }
		new inhouseid = pData[playerid][pInHouse];
		if(pData[playerid][pInHouse] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, hData[inhouseid][hIntposX], hData[inhouseid][hIntposY], hData[inhouseid][hIntposZ]))
		{
			pData[playerid][pInHouse] = -1;
			SetPlayerPositionEx(playerid, hData[inhouseid][hExtposX], hData[inhouseid][hExtposY], hData[inhouseid][hExtposZ], hData[inhouseid][hExtposA]);
			
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
		}
		//Family
		foreach(new fid : FAMILYS)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, fData[fid][fExtposX], fData[fid][fExtposY], fData[fid][fExtposZ]))
			{
				if(fData[fid][fIntposX] == 0.0 && fData[fid][fIntposY] == 0.0 && fData[fid][fIntposZ] == 0.0)
					return ErrorMsg(playerid, "Interior masih kosong, atau tidak memiliki interior.");

				if(pData[playerid][pFaction] == 0)
					if(pData[playerid][pFamily] == -1)
						return ErrorMsg(playerid, "You dont have registered for this door!");
					
				pData[playerid][pInFamily] = fid;	
				SetPlayerPositionEx(playerid, fData[fid][fIntposX], fData[fid][fIntposY], fData[fid][fIntposZ], fData[fid][fIntposA]);

				SetPlayerInterior(playerid, fData[fid][fInt]);
				SetPlayerVirtualWorld(playerid, fid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
			new difamily = pData[playerid][pInFamily];
			if(pData[playerid][pInFamily] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, fData[difamily][fIntposX], fData[difamily][fIntposY], fData[difamily][fIntposZ]))
			{
				pData[playerid][pInFamily] = -1;	
				SetPlayerPositionEx(playerid, fData[difamily][fExtposX], fData[difamily][fExtposY], fData[difamily][fExtposZ], fData[difamily][fExtposA]);

				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, WorldWeather);
			}
        }
	}

	//SAPD Taser/Tazer
	if(newkeys & KEY_FIRE && TaserData[playerid][TaserEnabled] && GetPlayerWeapon(playerid) == 0 && !IsPlayerInAnyVehicle(playerid) && TaserData[playerid][TaserCharged])
	{
  		TaserData[playerid][TaserCharged] = false;

	    new Float: x, Float: y, Float: z, Float: health;
     	GetPlayerPos(playerid, x, y, z);
	    PlayerPlaySound(playerid, 6003, 0.0, 0.0, 0.0);
	    ApplyAnimation(playerid, "KNIFE", "KNIFE_3", 4.1, 0, 1, 1, 0, 0, 1);
		pData[playerid][pActivityTime] = 0;
	    TaserData[playerid][ChargeTimer] = SetTimerEx("ChargeUp", 1000, true, "i", playerid);
		PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Recharge...");
		PlayerTextDrawShow(playerid, ActiveTD[playerid]);
		ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);

	    for(new i, maxp = MAX_PLAYERS; i <= maxp; ++i)
		{
	        if(!IsPlayerConnected(i)) continue;
          	if(playerid == i) continue;
          	if(TaserData[i][TaserCountdown] != 0) continue;
          	if(IsPlayerInAnyVehicle(i)) continue;
			if(GetPlayerDistanceFromPoint(i, x, y, z) > 2.0) continue;
			ClearAnimations(i, 1);
			TogglePlayerControllable(i, false);
   			ApplyAnimation(i, "CRACK", "crckdeth2", 4.1, 0, 0, 0, 1, 0, 1);
			PlayerPlaySound(i, 6003, 0.0, 0.0, 0.0);

			GetPlayerHealth(i, health);
			TaserData[i][TaserCountdown] = TASER_BASETIME + floatround((100 - health) / 12);
   			Info(i, "You got tased for %d secounds!", TaserData[i][TaserCountdown]);
			TaserData[i][GetupTimer] = SetTimerEx("TaserGetUp", 1000, true, "i", i);
			break;
	    }
	}
	//keybindengine 2
    if (newkeys & KEY_YES)
	{
        if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			if(pData[playerid][pStartEn] == 1)
				return Error(playerid, "Kamu sedang Menyalakan Mesin, Mohon Tunggu");

            callcmd::en(playerid, "");
        }
    }
	if(newkeys & KEY_HANDBRAKE && GetPlayerWeapon(playerid) == 24 && GetNearbyRobbery(playerid) >= 0)
	{
	    for(new i = 0; i < MAX_ROBBERY; i++)
		{
		    if(IsPlayerInRangeOfPoint(playerid, 2.3, RobberyData[i][robberyX], RobberyData[i][robberyY], RobberyData[i][robberyZ]))
			{
				if(Warung == true) return 1;
				new aid;
				SetTimerEx("RobWarung", 6000, false, "d", playerid);
				ApplyActorAnimation(aid, "ROB_BANK","SHP_HandsUp_Scr",4.0, 1, 0, 0, 0, 0);
				Warung = true;
				new label[100];
				format(label, sizeof label, "Penjaga");
				RobberyData[i][robberyText] = CreateDynamic3DTextLabel(label, COLOR_WHITE, RobberyData[i][robberyX], RobberyData[i][robberyY], RobberyData[i][robberyZ]+1.5, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, RobberyData[i][robberyWorld], RobberyData[i][robberyInt], -1, 10.0);
			}
		}
	}
	if((newkeys & KEY_YES))
	{
		if(GetNearbyTrash(playerid) >= 0)
		{
		    for(new i = 0; i < MAX_Trash; i++)
			{
				if(IsPlayerInRangeOfPoint(playerid, 2.3, TrashData[i][TrashX], TrashData[i][TrashY], TrashData[i][TrashZ]))
				{
				if(TrashData[i][Sampah] > 99) return ErrorMsg(playerid, "Sampah penuh!!");
				if(pData[playerid][sampahsaya] < 1) return 1;
				new total = pData[playerid][sampahsaya];
				pData[playerid][sampahsaya] -= total;
				new str[500];
				format(str, sizeof(str), "Removed_%dx", total);
				ShowItemBox(playerid, "Sampah", str, 2840, total);
				Inventory_Update(playerid);
				TrashData[i][Sampah] += total;
				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "UPDATE trash SET sampah='%d' WHERE ID='%d'", TrashData[i][Sampah], i);
				mysql_tquery(g_SQL, query);
				//StartPlayerLoadingBar(playerid, 1, "Membuang...");
				ShowProgressbar(playerid, "Membuang..", 2);
				ApplyAnimation(playerid,"GRENADE","WEAPON_throwu",4.0, 1, 0, 0, 0, 0, 1);
				Trash_Save(i);
				if(IsValidDynamic3DTextLabel(TrashData[i][TrashLabel]))
				DestroyDynamic3DTextLabel(TrashData[i][TrashLabel]);
				format(str, sizeof(str), "Trash Capacity {FFFF00}%d/100\n{ffffff}Tekan {00FF00}[ Y ] {ffffff}Untuk Membuang Sampah\nGunakan /bin untuk memungut sampah", TrashData[i][Sampah]);
				TrashData[i][TrashLabel] = CreateDynamic3DTextLabel(str, ARWIN, TrashData[i][TrashX], TrashData[i][TrashY], TrashData[i][TrashZ]+1.0, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, TrashData[i][TrashWorld], TrashData[i][TrashInt], -1, 10.0);
				}
			}
		}
	}
	if((newkeys & KEY_YES ))
	{
		foreach(new lid : Lockers)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.5, lData[lid][lPosX], lData[lid][lPosY], lData[lid][lPosZ]))
			{
				if(pData[playerid][pFaction] < 1)
				if(pData[playerid][pVip] < 1)
					return Error(playerid, "You cant use this commands!");
					
				if(pData[playerid][pVip] > 0 && lData[lid][lType] == 6)
				{
					ShowPlayerDialog(playerid, DIALOG_LOCKERVIP, DIALOG_STYLE_LIST, "VIP Locker", "Health\nWeapons\nClothing\nVip Toys", "Okay", "Cancel");
				}
				else if(pData[playerid][pFaction] == 1 && pData[playerid][pFaction] == lData[lid][lType])
				{
					ShowPlayerDialog(playerid, DIALOG_LOCKERSAPD, DIALOG_STYLE_LIST, "SAPD Lockers", "Toggle Duty\nHealth\nArmour\nWeapons\nClothing\nClothing War", "Proceed", "Cancel");
				}
				else if(pData[playerid][pFaction] == 2 && pData[playerid][pFaction] == lData[lid][lType])
				{
					ShowPlayerDialog(playerid, DIALOG_LOCKERSAGS, DIALOG_STYLE_LIST, "SAGS Lockers", "Toggle Duty\nHealth\nArmour\nWeapons\nClothing", "Proceed", "Cancel");
				}
				else if(pData[playerid][pFaction] == 3 && pData[playerid][pFaction] == lData[lid][lType])
				{
					ShowPlayerDialog(playerid, DIALOG_LOCKERSAMD, DIALOG_STYLE_LIST, "SAMD Lockers", "Toggle Duty\nHealth\nArmour\nWeapons\nDrugs\nClothing", "Proceed", "Cancel");
				}
				else if(pData[playerid][pFaction] == 4 && pData[playerid][pFaction] == lData[lid][lType])
				{
					ShowPlayerDialog(playerid, DIALOG_LOCKERSANEW, DIALOG_STYLE_LIST, "SANA Lockers", "Toggle Duty\nHealth\nArmour\nWeapons\nClothing", "Proceed", "Cancel");
				}
				else if(pData[playerid][pFaction] == 5 && pData[playerid][pFaction] == lData[lid][lType])
				{
					ShowPlayerDialog(playerid, DIALOG_LOCKERPEDAGANG, DIALOG_STYLE_LIST, "Go Car Lockers", "Toggle Duty\nHealth\nArmour\nGudang Pedagang\nClothing", "Proceed", "Cancel");
				}
				else return Error(playerid, "You are not in this faction type!");
			}
		}
	}
	if(newkeys & KEY_WALK)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 2, 2860.8999,-1858.2836,11.1444))//adolbotol
		{
  			callcmd::adolbotol(playerid, "");
		}
	}
	if(newkeys & KEY_YES)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 2, 287.7309, -105.9845, 1001.5156))//Olah kanabis
		{
  			callcmd::olahkanabis(playerid, "");
		}
		if(IsPlayerInRangeOfPoint(playerid, 2, 887.3530,-20.0613,63.3195))//ambilkanabis
        {
        	callcmd::ambilkanabis(playerid, "");
        }
        if(IsPlayerInRangeOfPoint(playerid, 2, 892.5521,-22.5117,63.2470))//ambilkanabis
        {
        	callcmd::ambilkanabis(playerid, "");
        }
		if(IsPlayerInRangeOfPoint(playerid, 2, 890.8713,-26.2132,63.2412))//ambilkanabis
        {
        	callcmd::ambilkanabis(playerid, "");
        }
        if(IsPlayerInRangeOfPoint(playerid, 2, 885.7568,-23.8099,63.2797))//ambilkanabis
        {
        	callcmd::ambilkanabis(playerid, "");
        }
	}
	if((newkeys & KEY_WALK))
	{
	    if(IsPlayerInRangeOfPoint(playerid, 3, 562.7084,1317.3960,11.2688))
        {
        	callcmd::kerjaminyak1(playerid, "");
        }
        else if(IsPlayerInRangeOfPoint(playerid, 3, 490.8356,1315.3344,10.0656))
        {
        	callcmd::kerjaminyak2(playerid, "");
        }
        else if(IsPlayerInRangeOfPoint(playerid, 3, 570.4109,1219.8687,11.7113))
        {
        	callcmd::saringminyak(playerid, "");
        }
	}
	if((newkeys & KEY_WALK))
	{
		if(IsPlayerInRangeOfPoint(playerid, 1, 689.8557,887.1973,-39.1684))
        {
        	if(pData[playerid][pProgress] == 1) return ErrorMsg(playerid, "Anda masih memiliki activity progress");
            if(pData[playerid][pTimeTambang1] != 0) return Error(playerid, "Kamu harus menunggu beberapa Detik Untuk mencari Batu di Point ini");
            if(GetPlayerWeapon(playerid) != 6) return Error(playerid, "Kamu harus Memegang Shovel");
        	callcmd::nambanglenz(playerid, "");
        	pData[playerid][pTimeTambang1] = 1;
        	SetTimerEx("TungguNambang1", 50000, false, "d", playerid);
        }
        else if(IsPlayerInRangeOfPoint(playerid, 1, 694.7534,885.7076,-38.7663))
        {
        	if(pData[playerid][pProgress] == 1) return ErrorMsg(playerid, "Anda masih memiliki activity progress");
        	if(pData[playerid][pTimeTambang2] != 0) return Error(playerid, "Kamu harus menunggu beberapa Detik Untuk mencari Batu di Point ini");
        	if(GetPlayerWeapon(playerid) != 6) return Error(playerid, "Kamu harus Memegang Shovel");
        	callcmd::nambanglenz(playerid, "");
        	pData[playerid][pTimeTambang2] = 1;
        	SetTimerEx("TungguNambang2", 50000, false, "d", playerid);
        }
        else if(IsPlayerInRangeOfPoint(playerid, 1, 698.5974,889.7535,-38.6046))
        {
        	if(pData[playerid][pProgress] == 1) return ErrorMsg(playerid, "Anda masih memiliki activity progress");
        	if(pData[playerid][pTimeTambang3] != 0) return Error(playerid, "Kamu harus menunggu beberapa Detik Untuk mencari Batu di Point ini");
        	if(GetPlayerWeapon(playerid) != 6) return Error(playerid, "Kamu harus Memegang Shovel");
        	callcmd::nambanglenz(playerid, "");
        	pData[playerid][pTimeTambang3] = 1;
        	SetTimerEx("TungguNambang3", 50000, false, "d", playerid);
        }
        else if(IsPlayerInRangeOfPoint(playerid, 1, 699.5721,896.2081,-38.6654))
        {
        	if(pData[playerid][pProgress] == 1) return ErrorMsg(playerid, "Anda masih memiliki activity progress");
        	if(pData[playerid][pTimeTambang4] != 0) return Error(playerid, "Kamu harus menunggu beberapa Detik Untuk mencari Batu di Point ini");
        	if(GetPlayerWeapon(playerid) != 6) return Error(playerid, "Kamu harus Memegang Shovel");
        	callcmd::nambanglenz(playerid, "");
        	pData[playerid][pTimeTambang4] = 1;
        	SetTimerEx("TungguNambang4", 50000, false, "d", playerid);
        }
        else if(IsPlayerInRangeOfPoint(playerid, 1, 694.6160,897.4399,-39.0123))
        {
        	if(pData[playerid][pProgress] == 1) return ErrorMsg(playerid, "Anda masih memiliki activity progress");
        	if(pData[playerid][pTimeTambang5] != 0) return Error(playerid, "Kamu harus menunggu beberapa Detik Untuk mencari Batu di Point ini");
        	if(GetPlayerWeapon(playerid) != 6) return Error(playerid, "Kamu harus Memegang Shovel");
        	callcmd::nambanglenz(playerid, "");
        	pData[playerid][pTimeTambang5] = 1;
        	SetTimerEx("TungguNambang5", 50000, false, "d", playerid);
        }
        else if(IsPlayerInRangeOfPoint(playerid, 1, 689.3038,896.0177,-39.3825))
        {
        	if(pData[playerid][pProgress] == 1) return ErrorMsg(playerid, "Anda masih memiliki activity progress");
        	if(pData[playerid][pTimeTambang6] != 0) return Error(playerid, "Kamu harus menunggu beberapa Detik Untuk mencari Batu di Point ini");
        	if(GetPlayerWeapon(playerid) != 6) return Error(playerid, "Kamu harus Memegang Shovel");
        	callcmd::nambanglenz(playerid, "");
        	pData[playerid][pTimeTambang6] = 1;
        	SetTimerEx("TungguNambang6", 50000, false, "d", playerid);
        }
        else if(IsPlayerInRangeOfPoint(playerid, 3, 540.4908,593.2016,0.3222))
        {
        	callcmd::nyucibatulenz(playerid, "");
        }
        else if(IsPlayerInRangeOfPoint(playerid, 3, 2152.539062,-2263.646972,13.300081))
        {
        	callcmd::peleburanbatulenz(playerid, "");
        }
	}
	//penambang batu bara
	if((newkeys & KEY_WALK))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3, 679.4178,895.3014,-40.0306))
		{
		    if(pData[playerid][pJob] != 4 && pData[playerid][pJob2] != 4) return Error(playerid, "Kamu bukan pekerja Penambang Batu");

		    ShowPlayerDialog(playerid, DIALOG_LOCKERPENAMBANG, DIALOG_STYLE_LIST, "One Pride {ffffff}- Locker Penambang batu", "Baju Kerja\nBaju Warga", "Pilih", "Kembali");
		}
	}

	//nambang minyak
	if((newkeys & KEY_WALK))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3, 577.0319,1223.9120,11.7113))
		{
		    if(pData[playerid][pJob] != 13 && pData[playerid][pJob2] != 13) return Error(playerid, "Kamu bukan pekerja Penambang Minyak");

		    ShowPlayerDialog(playerid, DIALOG_LOCKERMINYAK, DIALOG_STYLE_LIST, "One Pride {ffffff}- Locker Penambang Minyak", "Baju Kerja\nBaju Warga", "Pilih", "Kembali");
		}
	}
	//sell hasil tambang & minyak 
	if(PRESSED( KEY_WALK ))
    {
    	if(IsPlayerInRangeOfPoint(playerid, 2.0, 2860.5452,-1877.3788,11.1444))
		{
		    if(pData[playerid][pProgress] == 1) return ErrorMsg(playerid, "Anda masih memiliki activity progress!");
			PlayerPlaySound(playerid, 5202, 0,0,0);
			new string[10000];
		    format(string, sizeof(string), "nambang\t\tHarga\nGas\t\t"LG_E"$15/{ffffff}1 Kotak\nEmas\t\t"LG_E"$25/{ffffff}1 emas\nBesi\t\t"LG_E"$15/{ffffff}1 Besi\nAluminium\t\t"LG_E"$10/{ffffff}1 Tembaga");
	    	ShowPlayerDialog(playerid, DIALOG_TAMBANG, DIALOG_STYLE_TABLIST_HEADERS, "One Pride Market -Hasil Nambang", string, "Jual", "Batal");
		}
    }
	if((newkeys & KEY_WALK))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 1392.5812,-8.2285,1000.9166))
		{
			ShowPlayerDialog(playerid, MENCET_DISNAKER, DIALOG_STYLE_TABLIST_HEADERS, "Dinas Tenaga Kerja Kota One Pride", "No\tType\tNo/Vip\n1.\tDisnaker\tNo\n2.\tDisnaker\tVip", "Pilih", "Batal");
		}
	}
	if((newkeys & KEY_WALK ))
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.0, 1392.5812, -12.6790, 1000.9166))
		{
		    new str[246];
			PlayerPlaySound(playerid, 5202, 0,0,0);
		    format(str, sizeof(str),"Pilihan\t\t\t\t\tKeterangan\nBuat KTP\t\t\t\t\tUntuk Membuat Kartu Tanda Penduduk\nMengganti Tanggal Lahir\t\t\t\t\tUntuk Mengganti Tanggal Lahir Anda\nJual Rumah\t\t\t\t\tUntuk Menjual Rumah Jika Anda Memiliki Rumah\nJual Bisnis\t\t\t\t\tUntuk Menjual Bisnis/Toko Yang Anda Miliki");
		    ShowPlayerDialog(playerid, DIALOG_PEMERINTAH, DIALOG_STYLE_TABLIST_HEADERS, ""WHITE_E"PEMERINTAH One Pride", str, "Select", "Cancel");
	    }
	}
	if(newkeys & KEY_YES)
	{
	    if(pData[playerid][pFaction] == 3)
        {
            foreach(new i : Player) if(IsPlayerConnected(i) && NearPlayer(playerid, i, 1) && i != playerid)
			{
				ShowPlayerDialog(playerid, DIALOG_EMS1, DIALOG_STYLE_LIST, "One Pride - SAMD Panel", "Revive\nGendong\nCheck Health\nInvoice Manual\nTreatment\nHealBone\nLoadInjured\nDropInjured", "Select", "Cancel");
			}
		}
	}
	if(newkeys & KEY_YES)
	{
	    if(pData[playerid][pFaction] == 1)
        {
            foreach(new i : Player) if(IsPlayerConnected(i) && NearPlayer(playerid, i, 1) && i != playerid)
			{
				ShowPlayerDialog(playerid, DIALOG_SAPDPANEL, DIALOG_STYLE_LIST, "One Pride - SAPD Panel", "Borgol\nBuka Borgol\nMasukkan/Keluarkan paksa ( car )\nGendong\nPeriksa\nAmbil Barang Paksa", "Select", "Cancel");
			}
		}
	}
	if((newkeys & KEY_WALK))//cafe
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 1239.4235,-1327.6514,14.1152))
		{
 			for(new i = 0; i < 33; i++) {
				TextDrawShowForPlayer(playerid, cafelenz[i]);
			}
			TextDrawShowForPlayer(playerid, burgere);
			TextDrawShowForPlayer(playerid, cakee);
			TextDrawShowForPlayer(playerid, susune);
			TextDrawShowForPlayer(playerid, kebabe);
			TextDrawShowForPlayer(playerid, rokoke);
			TextDrawShowForPlayer(playerid, nasbunge);
			TextDrawShowForPlayer(playerid, jeruke);
			TextDrawShowForPlayer(playerid, amere);
			TextDrawShowForPlayer(playerid, tutupe);
			SelectTextDraw(playerid, 0xFF0000FF);
		}
	}
	//-----[ Toll System ]-----	
	if(newkeys & KEY_CROUCH)
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
		{
			new forcount = MuchNumber(sizeof(BarrierInfo));
			for(new i;i < forcount;i ++)
			{
				if(i < sizeof(BarrierInfo))
				{
					if(IsPlayerInRangeOfPoint(playerid,8,BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]))
					{
						if(BarrierInfo[i][brOrg] == TEAM_NONE)
						{
							if(!BarrierInfo[i][brOpen])
							{
								if(pData[playerid][pMoney] < 5)
								{
									Toll(playerid, "Uangmu tidak cukup untuk membayar toll");
								}
								else
								{
									MoveDynamicObject(gBarrier[i],BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.7,BARRIER_SPEED,0.0,0.0,BarrierInfo[i][brPos_A]+180);
									SetTimerEx("BarrierClose",5000,0,"i",i);
									BarrierInfo[i][brOpen] = true;
									Toll(playerid, "Toll akan segera menutup kembali pembatas dalam 5 detik");
									GivePlayerMoneyEx(playerid, -5);
									ShowItemBox(playerid, "Uang", "Removed_$5", 1212, 4);
									if(BarrierInfo[i][brForBarrierID] != -1)
									{
										new barrierid = BarrierInfo[i][brForBarrierID];
										MoveDynamicObject(gBarrier[barrierid],BarrierInfo[barrierid][brPos_X],BarrierInfo[barrierid][brPos_Y],BarrierInfo[barrierid][brPos_Z]+0.7,BARRIER_SPEED,0.0,0.0,BarrierInfo[barrierid][brPos_A]+180);
										BarrierInfo[barrierid][brOpen] = true;

									}
								}
							}
						}
						else Toll(playerid, "Kamu tidak bisa membuka pintu Toll ini!");
						break;
					}
				}
			}
		}
		return true;		
	}
	if(GetPVarInt(playerid, "UsingSprunk"))
	{
		if(pData[playerid][pEnergy] >= 100 )
		{
  			InfoMsg(playerid, " Kamu terlalu banyak minum.");
	   	}
	   	else
	   	{
		    pData[playerid][pEnergy] += 5;
		}
	}
	// STREAMER MASK SYSTEM
	if(PRESSED( KEY_WALK ))
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			if(pData[playerid][pAdmin] < 2)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				if(GetEngineStatus(vehicleid))
				{
					if(GetVehicleSpeed(vehicleid) <= 40)
					{
						new playerState = GetPlayerState(playerid);
						if(playerState == PLAYER_STATE_DRIVER)
						{
							SendClientMessageToAllEx(COLOR_RED, "[ANTICHEAT]: "GREY2_E"%s have been auto kicked for vehicle engine hack!", pData[playerid][pName]);
							KickEx(playerid);
						}
					}
				}
			}	
		}
	}
	if(PRESSED( KEY_YES ))
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
		{
			foreach(new did : Doors)
			{
				if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]))
				{
					if(dData[did][dGarage] == 1)
					{
						if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
							return ErrorMsg(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

						if(dData[did][dLocked])
							return ErrorMsg(playerid, "This entrance is locked at the moment.");
							
						if(dData[did][dFaction] > 0)
						{
							if(dData[did][dFaction] != pData[playerid][pFaction])
								return ErrorMsg(playerid, "This door only for faction.");
						}
						if(dData[did][dFamily] > 0)
						{
							if(dData[did][dFamily] != pData[playerid][pFamily])
								return ErrorMsg(playerid, "This door only for family.");
						}
						
						if(dData[did][dVip] > pData[playerid][pVip])
							return ErrorMsg(playerid, "Your VIP level not enough to enter this door.");
						
						if(dData[did][dAdmin] > pData[playerid][pAdmin])
							return ErrorMsg(playerid, "Your admin level not enough to enter this door.");
							
						if(strlen(dData[did][dPass]))
						{
							new params[256];
							if(sscanf(params, "s[256]", params)) return SyntaxMsg(playerid, "/enter [password]");
							if(strcmp(params, dData[did][dPass])) return ErrorMsg(playerid, "Invalid door password.");
							
							if(dData[did][dCustom])
							{
								SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							else
							{
								SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							pData[playerid][pInDoor] = did;
							SetPlayerInterior(playerid, dData[did][dIntint]);
							SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
							SetCameraBehindPlayer(playerid);
							SetPlayerWeather(playerid, 0);
						}
						else
						{
							if(dData[did][dCustom])
							{
								SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							else
							{
								SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							pData[playerid][pInDoor] = did;
							SetPlayerInterior(playerid, dData[did][dIntint]);
							SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
							SetCameraBehindPlayer(playerid);
							SetPlayerWeather(playerid, 0);
						}
					}
				}
				if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]))
				{
					if(dData[did][dGarage] == 1)
					{
						if(dData[did][dFaction] > 0)
						{
							if(dData[did][dFaction] != pData[playerid][pFaction])
								return ErrorMsg(playerid, "This door only for faction.");
						}
					
						if(dData[did][dCustom])
						{
							SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
						}
						else
						{
							SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
						}
						pData[playerid][pInDoor] = -1;
						SetPlayerInterior(playerid, dData[did][dExtint]);
						SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, WorldWeather);
					}
				}
			}
		}
	}
	//if(IsKeyJustDown(KEY_CTRL_BACK,newkeys,oldkeys))
	if(PRESSED( KEY_CTRL_BACK ))
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && pData[playerid][pCuffed] == 0)
		{
			if(pData[playerid][pLoopAnim])
	    	{	
	        	pData[playerid][pLoopAnim] = 0;

				ClearAnimations(playerid, 1);
				StopLoopingAnim(playerid);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		    	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
		    	TextDrawHideForPlayer(playerid, AnimationTD);
			}
			
		}
    }
	if(IsKeyJustDown(KEY_SECONDARY_ATTACK, newkeys, oldkeys))
	{
		if(GetPVarInt(playerid, "UsingSprunk"))
		{
			DeletePVar(playerid, "UsingSprunk");
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		}
	}
	if(takingselfie[playerid] == 1)
	{
		if(PRESSED(KEY_ANALOG_RIGHT))
		{
			GetPlayerPos(playerid,lX[playerid],lY[playerid],lZ[playerid]);
			static Float: n1X, Float: n1Y;
		    if(Degree[playerid] >= 360) Degree[playerid] = 0;
		    Degree[playerid] += Speed;
		    n1X = lX[playerid] + Radius * floatcos(Degree[playerid], degrees);
		    n1Y = lY[playerid] + Radius * floatsin(Degree[playerid], degrees);
		    SetPlayerCameraPos(playerid, n1X, n1Y, lZ[playerid] + Height);
		    SetPlayerCameraLookAt(playerid, lX[playerid], lY[playerid], lZ[playerid]+1);
		    SetPlayerFacingAngle(playerid, Degree[playerid] - 90.0);
		}
		if(PRESSED(KEY_ANALOG_LEFT))
		{
		    GetPlayerPos(playerid,lX[playerid],lY[playerid],lZ[playerid]);
			static Float: n1X, Float: n1Y;
		    if(Degree[playerid] >= 360) Degree[playerid] = 0;
		    Degree[playerid] -= Speed;
		    n1X = lX[playerid] + Radius * floatcos(Degree[playerid], degrees);
		    n1Y = lY[playerid] + Radius * floatsin(Degree[playerid], degrees);
		    SetPlayerCameraPos(playerid, n1X, n1Y, lZ[playerid] + Height);
		    SetPlayerCameraLookAt(playerid, lX[playerid], lY[playerid], lZ[playerid]+1);
		    SetPlayerFacingAngle(playerid, Degree[playerid] - 90.0);
		}
	}
	/*if(StatusCrateTerangkat == true)
    {
        if(PRESSED (KEY_JUMP))
        {
            ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, 1, 1, 1, 1, 1, 1);
        }
    }*/
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	//JOB KURIR
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)
	{
		/*if(IsAKurirVeh(GetPlayerVehicleID(playerid)))
		{
			GameTextForPlayer(playerid, "~w~PENGANTARAN BARANG TERSEDIA /STARTKURIR", 5000, 3);
			SendClientMessage(playerid, 0x76EEC6FF, "* Tampaknya ada paket yang tidak terkirim di Burrito Anda.");
		}*/
		if(IsABaggageVeh(GetPlayerVehicleID(playerid)))
		{
			InfoTD_MSG(playerid, 8000, "/startbg");
		}
	}

	// anti kebal kendaraan
	new strings[256],Float:KOR[3];
	if(newstate == PLAYER_STATE_PASSENGER || oldstate == PLAYER_STATE_PASSENGER || newstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_DRIVER)
	{
		new cars = GetPlayerVehicleID(playerid);
		GetVehiclePos(cars,KOR[0],KOR[1],KOR[2]);
		if(GetTickCount()- GetPVarInt(playerid, "anticarshoot") < 500)
		{
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid, name, sizeof(name));
			SetVehiclePos(cars,KOR[0],KOR[1],KOR[2]);
			format(strings,sizeof(strings)," %s Terdeteksi Citer Lempar Kendaraan.",name);
			SendStaffMessage(COLOR_RED, strings);
			Kick(playerid);
		}
		SetPVarInt(playerid,"anticarshoot",GetTickCount());
	}

	if(newstate == PLAYER_STATE_WASTED && pData[playerid][pJail] < 1)
    {	
		if(pData[playerid][pInjured] == 0)
        {
            pData[playerid][pInjured] = 1;
            SetPlayerHealthEx(playerid, 99999);

            pData[playerid][pInt] = GetPlayerInterior(playerid);
            pData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);

            GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
            GetPlayerFacingAngle(playerid, pData[playerid][pPosA]);
        }
        else
        {
        	pData[playerid][pDelaySpawn] = gettime() + 18000;
            pData[playerid][pHospital] = 1;
        }
	}
	//Spec Player
	new vehicleid = GetPlayerVehicleID(playerid);
	if(newstate == PLAYER_STATE_ONFOOT)
	{
		if(pData[playerid][playerSpectated] != 0)
		{
			foreach(new ii : Player)
			{
				if(pData[ii][pSpec] == playerid)
				{
					PlayerSpectatePlayer(ii, playerid);
					Servers(ii, ,"%s(%i) is now on foot.", pData[playerid][pName], playerid);
				}
			}
		}
	}
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
    {
		pData[playerid][pMarkTemp] = vehicleid;
		if(pData[playerid][pInjured] == 1)
        {
        	pData[playerid][pDelaySpawn] = gettime() + 18000;
            //RemoveFromVehicle(playerid);
			RemovePlayerFromVehicle(playerid);
            SetPlayerHealthEx(playerid, 99999);
        }
		foreach (new ii : Player) if(pData[ii][pSpec] == playerid) 
		{
            PlayerSpectateVehicle(ii, GetPlayerVehicleID(playerid));
        }
	}
	if(oldstate == PLAYER_STATE_PASSENGER)
	{
		//TextDrawHideForPlayer(playerid, TDEditor_TD[11]);
		TextDrawHideForPlayer(playerid, DPvehfare[playerid]);
	}
	if(oldstate == PLAYER_STATE_DRIVER)
    {	
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CARRY || GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED)
            return RemovePlayerFromVehicle(playerid);/*RemoveFromVehicle(playerid);*/
	
		// if(pData[playerid][pHBEMode] == 1)
		// {
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][0]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][1]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][2]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][3]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][4]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][5]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][6]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][7]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][8]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][9]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][10]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][11]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][12]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][13]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][14]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][15]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][16]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][17]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][18]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][19]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][20]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][21]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][22]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][23]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][24]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][25]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][26]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][27]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][28]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][29]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][30]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][31]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][32]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][33]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][34]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][35]);
		// 	PlayerTextDrawHide(playerid, L3nzHUDVM[playerid][36]);
		// 	PlayerTextDrawHide(playerid, bensinhudava[playerid]);
		// 	PlayerTextDrawHide(playerid, bar1[playerid]);
		// 	PlayerTextDrawHide(playerid, bar2[playerid]);
		// 	PlayerTextDrawHide(playerid, bar3[playerid]);
		// 	PlayerTextDrawHide(playerid, bar4[playerid]);
		// 	PlayerTextDrawHide(playerid, bar5[playerid]);
		// 	PlayerTextDrawHide(playerid, bar6[playerid]);
		// 	PlayerTextDrawHide(playerid, bar7[playerid]);
		// 	PlayerTextDrawHide(playerid, bar8[playerid]);
		// 	PlayerTextDrawHide(playerid, bar9[playerid]);
		// 	PlayerTextDrawHide(playerid, bar10[playerid]);
		// 	PlayerTextDrawHide(playerid, bar11[playerid]);
		// 	PlayerTextDrawHide(playerid, bar12[playerid]);
		// 	PlayerTextDrawHide(playerid, bar13[playerid]);
		// 	PlayerTextDrawHide(playerid, bar14[playerid]);
		// 	PlayerTextDrawHide(playerid, bar15[playerid]);
		// 	PlayerTextDrawHide(playerid, bar16[playerid]);
		// 	PlayerTextDrawHide(playerid, bar17[playerid]);
		// 	PlayerTextDrawHide(playerid, bar18[playerid]);
		// 	PlayerTextDrawHide(playerid, bar19[playerid]);
		// 	PlayerTextDrawHide(playerid, bar20[playerid]);
		// 	PlayerTextDrawHide(playerid, bar21[playerid]);
		// 	PlayerTextDrawHide(playerid, bar22[playerid]);
		// }
		if(pData[playerid][pHBEMode] == 1)
		{

            for(new i = 0; i < 9; i++)
			{
				PlayerTextDrawHide(playerid, LenzVHud[playerid][i]);
			}
			PlayerTextDrawHide(playerid, mataangin[playerid]);
			PlayerTextDrawHide(playerid, gpshud[playerid]);
			PlayerTextDrawHide(playerid, enginehud[playerid]);
			PlayerTextDrawHide(playerid, jamhud[playerid]);
			PlayerTextDrawHide(playerid, banterhud[playerid]);
			PlayerTextDrawHide(playerid, bensinhud[playerid]);
			PlayerTextDrawHide(playerid, mobilhud[playerid]);
			PlayerTextDrawHide(playerid, nyowohud[playerid]);
		}
		if(pData[playerid][pHBEMode] == 2)
		{
			for(new i = 0; i < 5; i++)
			{
				PlayerTextDrawHide(playerid, spedometer[playerid][i]);
			}
			PlayerTextDrawHide(playerid, BensinTry[playerid]);
			PlayerTextDrawHide(playerid, DamageTry[playerid]);
			PlayerTextDrawHide(playerid, KecepatanTry[playerid]);
			PlayerTextDrawHide(playerid, SultanTry[playerid]);
			PlayerTextDrawHide(playerid, JamTry[playerid]);
		}

		
		if(pData[playerid][pTaxiDuty] == 1)
		{
			pData[playerid][pTaxiDuty] = 0;
			SetPlayerColor(playerid, COLOR_WHITE);
			Servers(playerid, "You are no longer on taxi duty!");
		}
		if(pData[playerid][pFare] == 1)
		{
			KillTimer(pData[playerid][pFareTimer]);
			Info(playerid, "Anda telah menonaktifkan taxi fare pada total: {00FF00}%s", FormatMoney(pData[playerid][pTotalFare]));
			pData[playerid][pFare] = 0;
			pData[playerid][pTotalFare] = 0;
		}
		if(pData[playerid][pIsStealing] == 1)
		{
			pData[playerid][pIsStealing] = 0;
			pData[playerid][pLastChopTime] = 0;
			InfoMsg(playerid, "Kamu gagal mencuri kendaraan ini..!!");
			KillTimer(MalingKendaraan);

		}
        
		HidePlayerProgressBar(playerid, pData[playerid][spfuelbar]);
        HidePlayerProgressBar(playerid, pData[playerid][spdamagebar]);
	}
	else if(newstate == PLAYER_STATE_DRIVER)
    {
		/*if(IsSRV(vehicleid))
		{
			new tstr[128], price = GetVehicleCost(GetVehicleModel(vehicleid));
			format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleName(vehicleid), FormatMoney(price));
			ShowPlayerDialog(playerid, DIALOG_BUYPV, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
		}
		else if(IsVSRV(vehicleid))
		{
			new tstr[128], price = GetVipVehicleCost(GetVehicleModel(vehicleid));
			if(pData[playerid][pVip] == 0)
			{
				ErrorMsg(playerid, "Kendaraan Khusus VIP Player.");
				RemovePlayerFromVehicle(playerid);
				//SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			}
			else
			{
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d Coin", GetVehicleName(vehicleid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYVIPPV, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
		}*/
		
		foreach(new pv : PVehicles)
		{
			if(vehicleid == pvData[pv][cVeh])
			{
				if(IsABike(vehicleid) || GetVehicleModel(vehicleid) == 424)
				{
					if(pvData[pv][cLocked] == 1)
					{
						RemovePlayerFromVehicle(playerid);
						//new Float:slx, Float:sly, Float:slz;
						//GetPlayerPos(playerid, slx, sly, slz);
						//SetPlayerPos(playerid, slx, sly, slz);
						ErrorMsg(playerid, "This bike is locked by owner.");
						return 1;
					}
				}
			}
		}
		//locktire
		foreach(new pv : PVehicles)
		{
			if(vehicleid == pvData[pv][cVeh])
			{
				if(pvData[pv][cLockTire] == 1)
				{
					RemovePlayerFromVehicle(playerid);
					ErrorMsg(playerid, "The tire of this vehicle is locked by SAPD. Call SAPD for unlocked it.");
					return 1;
				}
			}
		}
		if(GetVehicleModel(vehicleid) == 431)
		{
			pData[playerid][pSideJob] = 2;
			pData[playerid][pBus] = 1;
			SetPlayerRaceCheckpoint(playerid, 2, buspoint1, buspoint1, 4.0);
			pData[playerid][pCheckPoint] = CHECKPOINT_BUS;
			InfoTD_MSG(playerid, 3000, "Ikuti Checkpoint!");
		}
		if(GetVehicleModel(vehicleid) == 574)
		{
			ShowPlayerDialog(playerid, DIALOG_SWEEPER, DIALOG_STYLE_MSGBOX, "Side Job - Sweeper", "Anda akan bekerja sebagai pembersih jalan?", "Start Job", "Close");
		}
		if(IsAStreakVeh(vehicleid))
		{
			ShowPlayerDialog(playerid, DIALOG_STREAK, DIALOG_STYLE_MSGBOX, "Side Job - Streak", "Anda akan bekerja sebagai Masinis?", "Start Job", "Close");
		}
		if(GetVehicleModel(vehicleid) == 448)
		{
			ShowPlayerDialog(playerid, DIALOG_PIZZA, DIALOG_STYLE_MSGBOX, "Side Job - Pizza", "Anda akan bekerja sebagai pengantar Pizza?", "Start Job", "Close");
		}
		if(IsABusVeh(vehicleid))
		{
			ShowPlayerDialog(playerid, DIALOG_BUS, DIALOG_STYLE_MSGBOX, "Side Job - Bus", "Anda akan bekerja sebagai pengangkut penumpang bus?", "Start Job", "Close");
		}
		if(IsAForVeh(vehicleid))
		{
			ShowPlayerDialog(playerid, DIALOG_FORKLIFT, DIALOG_STYLE_MSGBOX, "Side Job - Forklift", "Anda akan bekerja sebagai pemuat barang dengan Forklift?", "Start Job", "Close");
		}
		if(IsAMowerVeh(vehicleid))
		{
			ShowPlayerDialog(playerid, DIALOG_MOWER, DIALOG_STYLE_MSGBOX, "Side Job - Mower", "Anda akan bekerja sebagai Mower?", "Start Job", "Close");
		}
		if(IsABaggageVeh(vehicleid))
		{
			if(pData[playerid][pJob] != 9 && pData[playerid][pJob2] != 9)
			{
				RemovePlayerFromVehicle(playerid);
                ErrorMsg(playerid, "Kamu tidak bekerja sebagai Baggage Airport");
			}
		}
		if(IsADmvVeh(vehicleid))
        {
            if(!pData[playerid][pDriveLicApp])
            {
                RemovePlayerFromVehicle(playerid);
                ErrorMsg(playerid, "Kamu tidak sedang mengikuti Tes Mengemudi");
			}
			else 
			{
				InfoMsg(playerid, "Silahkan ikuti Checkpoint yang ada di GPS mobil ini.");
				SetPlayerRaceCheckpoint(playerid, 1, dmvpoint1, dmvpoint1, 5.0);
			}
		}
		/*if(IsAKurirVeh(vehicleid))
		{
			if(pData[playerid][pJob] != 8 && pData[playerid][pJob2] != 8)
			{
				RemovePlayerFromVehicle(playerid);
                ErrorMsg(playerid, "Kamu tidak bekerja sebagai Courier");
			}
		}*/
		if(IsSAPDCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 1)
			{
			    RemovePlayerFromVehicle(playerid);
			    ErrorMsg(playerid, "Anda bukan SAPD!");
			}
		}
		if(IsGovCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 2)
			{
			    RemovePlayerFromVehicle(playerid);
			    ErrorMsg(playerid, "Anda bukan SAGS!");
			}
		}
		if(IsSAMDCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 3)
			{
			    RemovePlayerFromVehicle(playerid);
			    ErrorMsg(playerid, "Anda bukan SAMD!");
			}
		}
		if(IsSANACar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 4)
			{
			    RemovePlayerFromVehicle(playerid);
			    ErrorMsg(playerid, "Anda bukan SANEWS!");
			}
		}
		if(IsGOCARCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 5)
			{
			    RemovePlayerFromVehicle(playerid);
			    ErrorMsg(playerid, "Anda bukan Pedagang!");
			}
		}
		if(!IsEngineVehicle(vehicleid))
        {
            SwitchVehicleEngine(vehicleid, true);
        }
		if(IsEngineVehicle(vehicleid) && pData[playerid][pDriveLic] <= 0)
        {
            Info(playerid, "Anda tidak memiliki surat izin mengemudi.");
			//Info(playerid, ""COLOR_RED"CMD : "LB_E"/en "YELLOW_E"Untuk Menyalakan Kendaraan");
        }
		if(pData[playerid][pHBEMode] == 1)
		{
			Info(playerid, "{00ffff}[Vehicle] {ffffff}Gunakan {00ffff}Otot N{ffffff} Untuk Membuka Menu Kendaraan.");
			new Float:fDamage, fFuel, color1, color2;
			//static Float:bengsin;
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y, z);

			GetVehicleColor(vehicleid, color1, color2);

			GetVehicleHealth(vehicleid, fDamage);
			if(fDamage <= 350) fDamage = 0;
			else if(fDamage > 5000) fDamage = 5000;
			
			fFuel = GetVehicleFuel(vehicleid);
			if(fFuel < 0) fFuel = 0;
			else if(fFuel > 1000) fFuel = 1000;

			new str[400];
			for(new i = 0; i < 9; i++)
			{
				PlayerTextDrawShow(playerid, LenzVHud[playerid][i]);
			}
			//engine
			if(!GetEngineStatus(vehicleid))
			{
				PlayerTextDrawSetString(playerid, enginehud[playerid], "OFF");
			}
			else
			{
				PlayerTextDrawSetString(playerid, enginehud[playerid], "ON");
			}
			PlayerTextDrawShow(playerid, enginehud[playerid]);
			//gpslokasi
			format(str, sizeof(str), "%s", GetLocation(x, y, z));
			PlayerTextDrawSetString(playerid, gpshud[playerid], str);
			PlayerTextDrawShow(playerid, gpshud[playerid]);
			//kecepatan
			format(str, sizeof(str), "%.0f", GetVehicleSpeed(vehicleid));
			PlayerTextDrawSetString(playerid, banterhud[playerid], str);
			PlayerTextDrawShow(playerid, banterhud[playerid]);
			//damageveh
			format(str, sizeof(str), "%.0f", fDamage);
			PlayerTextDrawSetString(playerid, nyowohud[playerid], str);
			PlayerTextDrawShow(playerid, nyowohud[playerid]);
			//bensine
			format(str, sizeof(str), "%d", fFuel / 10);
			PlayerTextDrawSetString(playerid, bensinhud[playerid], str);
			PlayerTextDrawShow(playerid, bensinhud[playerid]);		
			//namamobil		
			format(str, sizeof(str), "%s", GetVehicleName(vehicleid));
			PlayerTextDrawSetString(playerid, mobilhud[playerid], str);
			PlayerTextDrawShow(playerid, mobilhud[playerid]);
			//jamspedo
			PlayerTextDrawShow(playerid, jamhud[playerid]);
			new Float:rz;
			if(IsPlayerInAnyVehicle(playerid))
			{
				GetVehicleZAngle(GetPlayerVehicleID(playerid), rz);
			}
			else
			{
				GetPlayerFacingAngle(playerid, rz);
			}

			if(rz >= 348.75 || rz < 11.25) PlayerTextDrawSetString(playerid, mataangin[playerid], "N");
			else if(rz >= 326.25 && rz < 348.75) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
			else if(rz >= 303.75 && rz < 326.25) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
			else if(rz >= 281.25 && rz < 303.75) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
			else if(rz >= 258.75 && rz < 281.25) PlayerTextDrawSetString(playerid, mataangin[playerid], "E");
			else if(rz >= 236.25 && rz < 258.75) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
			else if(rz >= 213.75 && rz < 236.25) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
			else if(rz >= 191.25 && rz < 213.75) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
			else if(rz >= 168.75 && rz < 191.25) PlayerTextDrawSetString(playerid, mataangin[playerid], "S");
			else if(rz >= 146.25 && rz < 168.75) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
			else if(rz >= 123.25 && rz < 146.25) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
			else if(rz >= 101.25 && rz < 123.25) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
			else if(rz >= 78.75 && rz < 101.25) PlayerTextDrawSetString(playerid, mataangin[playerid], "W");
			else if(rz >= 56.25 && rz < 78.75) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
			else if(rz >= 33.75 && rz < 56.25) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
			else if(rz >= 11.5 && rz < 33.75) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
			PlayerTextDrawShow(playerid, mataangin[playerid]);
    	}
    	if(pData[playerid][pHBEMode] == 2)
    	{
    		new Float:fDamage, fFuel, color1, color2;
			//static Float:bengsin;

			GetVehicleColor(vehicleid, color1, color2);

			GetVehicleHealth(vehicleid, fDamage);
			if(fDamage <= 350) fDamage = 0;
			else if(fDamage > 5000) fDamage = 5000;
			
			fFuel = GetVehicleFuel(vehicleid);
			if(fFuel < 0) fFuel = 0;
			else if(fFuel > 1000) fFuel = 1000;

			new str[400];
			for(new i = 0; i < 5; i++)
			{
				PlayerTextDrawShow(playerid, spedometer[playerid][i]);
			}
			//kecepatan
			format(str, sizeof(str), "%.0f", GetVehicleSpeed(vehicleid));
			PlayerTextDrawSetString(playerid, KecepatanTry[playerid], str);
			PlayerTextDrawShow(playerid, KecepatanTry[playerid]);
			//damage
			format(str, sizeof(str), "%.0f", fDamage);
			PlayerTextDrawSetString(playerid, DamageTry[playerid], str);
			PlayerTextDrawShow(playerid, DamageTry[playerid]);
			//fuel
			format(str, sizeof(str), "%d", fFuel / 10);
			PlayerTextDrawSetString(playerid, BensinTry[playerid], str);
			PlayerTextDrawShow(playerid, BensinTry[playerid]);	
			//jenismobil
			//PlayerTextDrawSetPreviewModel(playerid, SultanTry[playerid], GetVehicleModel(GetPlayerVehicleID(playerid)));
			//PlayerTextDrawSetPreviewVehCol(playerid, SultanTry[playerid], color1, color2);
			//PlayerTextDrawShow(playerid, SultanTry[playerid]);
			//jam
			PlayerTextDrawShow(playerid, JamTry[playerid]);
    	}
		new Float:health;
        GetVehicleHealth(GetPlayerVehicleID(playerid), health);
        VehicleHealthSecurityData[GetPlayerVehicleID(playerid)] = health;
        VehicleHealthSecurity[GetPlayerVehicleID(playerid)] = true;
		
		if(pData[playerid][playerSpectated] != 0)
  		{
			foreach(new ii : Player)
			{
    			if(pData[ii][pSpec] == playerid)
			    {
        			PlayerSpectateVehicle(ii, vehicleid);
				    Servers(ii, "%s(%i) is now driving a %s(%d).", pData[playerid][pName], playerid, GetVehicleModelName(GetVehicleModel(vehicleid)), vehicleid);
				}
			}
		}
		SetPVarInt(playerid, "LastVehicleID", vehicleid);
	//specnew
	}
	return 1;
}
public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid) 
{
 	return 1;
}
function UnToggle(playerid)
{
	TogglePlayerControllable(playerid, true);
	SetCameraBehindPlayer(playerid);
	return 1;
}
function WaktuKeluar(playerid)
{
 	if(IsValidDynamic3DTextLabel(TagKeluar[playerid]))
  		DestroyDynamic3DTextLabel(TagKeluar[playerid]);
}
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{

	switch(weaponid){ case 0..18, 39..54: return 1;} //invalid weapons
	if(1 <= weaponid <= 46 && pData[playerid][pGuns][g_aWeaponSlots[weaponid]] == weaponid)
	{
		pData[playerid][pAmmo][g_aWeaponSlots[weaponid]]--;
		if(pData[playerid][pGuns][g_aWeaponSlots[weaponid]] != 0 && !pData[playerid][pAmmo][g_aWeaponSlots[weaponid]])
		{
			pData[playerid][pGuns][g_aWeaponSlots[weaponid]] = 0;
		}
		if(hittype == 1 && GetDamageID[hitid] == INVALID_PLAYER_ID)
		{
			GetDamageID[hitid] = playerid;
		}
	}
	return 1;
}
stock IsACBUGWeapon(playerid)
{
	if (IsPlayerConnected(playerid))
	{
	    new Lenzwp = GetPlayerWeapon ( playerid ) ;
	    if (Lenzwp == 24 || Lenzwp == 25 || Lenzwp == 27 || Lenzwp == 34 ) return 1 ;
	}
	return 0 ;
}
stock GivePlayerHealth(playerid,Float:Health)
{
	new Float:health; GetPlayerHealth(playerid,health);
	SetPlayerHealth(playerid,health+Health);
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
    new Float: p_HP;
    GetPlayerHealth(playerid, p_HP);
    if(pData[playerid][pSeatBelt] == 0 || pData[playerid][pHelmetOn] == 0)
    {
        SetPlayerHealth(playerid, p_HP-3);
        PlayerPlaySound(playerid, 1130, 0.0,0.0,0.0);
        //SetTimerEx("HidePlayerBox", 500, false, "dd", playerid, _:ShowPlayerBox(playerid, 0xFF000066));
    }

	new
        Float: vehicleHealth,
        playerVehicleId = GetPlayerVehicleID(playerid);

    //new Float:health = GetPlayerHealth(playerid, health);
    GetVehicleHealth(playerVehicleId, vehicleHealth);

	new panel, doors, lights, tires, Float: HP, Float:pHP;
	GetVehicleHealth(vehicleid, pHP);
	foreach(new i : PVehicles)
    {
        if(vehicleid == pvData[i][cVeh])
		{
		    if(pvData[i][cUpgrade][0] == 1)
		    {
			    GetVehicleHealth(pvData[i][cVeh], HP);
			    if(HP >= 8000)
			    {
				    GetVehicleDamageStatus(vehicleid, panel, doors, lights, tires);
			        UpdateVehicleDamageStatus(vehicleid, 0, 0, 0, 0);
				}
				else
				{
				    GetVehicleDamageStatus(vehicleid, panel, doors, lights, tires);
				    UpdateVehicleDamageStatus(vehicleid, panel, doors, lights, tires);
			  	}
			}
		}
	}
    if(pData[playerid][pSeatBelt] == 0 || pData[playerid][pHelmetOn] == 0)
    {
    	if(GetVehicleSpeed(vehicleid) <= 50)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		pData[playerid][pLFoot] -= csakit;
    		pData[playerid][pLHand] -= bsakit;
    		pData[playerid][pRFoot] -= csakit;
    		pData[playerid][pRHand] -= bsakit;
    		pData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -1);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) <= 70)
    	{
    		new asakit = RandomEx(0, 2);
    		new bsakit = RandomEx(0, 2);
    		new csakit = RandomEx(0, 2);
    		new dsakit = RandomEx(0, 2);
    		pData[playerid][pLFoot] -= dsakit;
    		pData[playerid][pLHand] -= bsakit;
    		pData[playerid][pRFoot] -= csakit;
    		pData[playerid][pRHand] -= dsakit;
    		pData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -2);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) <= 90)
    	{
    		new asakit = RandomEx(0, 3);
    		new bsakit = RandomEx(0, 3);
    		new csakit = RandomEx(0, 3);
    		new dsakit = RandomEx(0, 3);
    		pData[playerid][pLFoot] -= csakit;
    		pData[playerid][pLHand] -= csakit;
    		pData[playerid][pRFoot] -= dsakit;
    		pData[playerid][pRHand] -= bsakit;
    		pData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -2);
    		return 1;
    	}
    	return 1;
    }
    if(pData[playerid][pSeatBelt] == 1 || pData[playerid][pHelmetOn] == 1)
    {
    	if(GetVehicleSpeed(vehicleid) <= 50)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		pData[playerid][pLFoot] -= csakit;
    		pData[playerid][pLHand] -= bsakit;
    		pData[playerid][pRFoot] -= csakit;
    		pData[playerid][pRHand] -= bsakit;
    		pData[playerid][pHead] -= asakit;
    		//GivePlayerHealth(playerid, -1);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) <= 70)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		new dsakit = RandomEx(0, 1);
    		pData[playerid][pLFoot] -= dsakit;
    		pData[playerid][pLHand] -= bsakit;
    		pData[playerid][pRFoot] -= csakit;
    		pData[playerid][pRHand] -= dsakit;
    		pData[playerid][pHead] -= asakit;
    		//GivePlayerHealth(playerid, -1);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) <= 90)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		new dsakit = RandomEx(0, 1);
    		pData[playerid][pLFoot] -= csakit;
    		pData[playerid][pLHand] -= csakit;
    		pData[playerid][pRFoot] -= dsakit;
    		pData[playerid][pRHand] -= bsakit;
    		pData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -2);
    		return 1;
    	}
    }
    return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	new str[60];
	new Float:hp;
	GetPlayerHealth(playerid, hp);
	CreateDamageLog(playerid, Float:amount, weaponid, bodypart);
	if(IsPlayerNPC(issuerid) || !IsPlayerInAnyVehicle(issuerid)) return 0;
	//if(weaponid > 21 && weaponid < 34 || weaponid == 38)
	if(weaponid == 24)
	{
	    SetPlayerHealth(playerid, hp);
		TogglePlayerControllable(issuerid, 0);
		warnings{issuerid} ++;
		if(warnings{issuerid} < MAX_WARININGS)
		{
		    format(str, sizeof(str), "{FFFFFF}Please do not drive-by using Desert {FF0000}%d{FFFFFF}/{FF0000}%d", warnings{issuerid}, MAX_WARININGS);
		    ShowPlayerDialog(issuerid, 12221, DIALOG_STYLE_MSGBOX, "{FF0000}Drive-By", str, "Ok", "");
		    TogglePlayerControllable(issuerid, 1);
		}
		if(warnings{issuerid} >= MAX_WARININGS)
		{
		    ShowPlayerDialog(issuerid, 12221, DIALOG_STYLE_MSGBOX, "{FF0000}Drive-By", "{FF0000}You have been kicked for drive-by using Desert", "Ok", "");
		    KickEx(issuerid);
		}
	}

	new Float:Armor, Float:Health;
	GetPlayerArmour(playerid, Armor);
	GetPlayerHealth(playerid, Health);
	if(IsAtEvent[playerid] == 0)
	{
		new sakit = RandomEx(1, 4);
		new asakit = RandomEx(1, 5);
		new bsakit = RandomEx(1, 7);
		new csakit = RandomEx(1, 4);
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 9)
		{
			pData[playerid][pHead] -= 20;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 3)
		{
			pData[playerid][pPerut] -= sakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 6)
		{
			pData[playerid][pRHand] -= bsakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 5)
		{
			pData[playerid][pLHand] -= asakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 8)
		{
			pData[playerid][pRFoot] -= csakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 7)
		{
			pData[playerid][pLFoot] -= bsakit;
		}
	}
	else if(IsAtEvent[playerid] == 1)
	{
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 9)
		{
			GivePlayerHealth(playerid, -90);
			SendClientMessage(issuerid, -1,"{7fffd4}[ TDM ]{ffffff} Headshot!");
		}
	}
	if (Armor > 0 && weaponid == 9)
    {
        
        SetPlayerArmour(playerid, Armor); 
        SetPlayerHealth(playerid, Health); 
        amount = 0.0; 
    }
    else if (Armor > 0 && (weaponid == 0 || weaponid == 5))
    {
        
        SetPlayerArmour(playerid, Armor); 
        SetPlayerHealth(playerid, Health - amount); 
    }
    else if (Armor <= 0 && weaponid == 9)
    {
       
        SetPlayerHealth(playerid, Health); 
        amount = 0.0; 
    }
    else if (Armor <= 0 && (weaponid == 0 || weaponid == 5))
    {
        
        SetPlayerHealth(playerid, Health - amount); 
    }
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO playerdamages(owner, issuer, amount, weaponid, bodypart, date) VALUES ('%d', '%s', '%.2f', '%d', '%d', CURRENT_TIMESTAMP())", pData[playerid][pID], pData[issuerid][pName], amount, weaponid, bodypart);
	mysql_tquery(g_SQL, query);
    return 1;
}


public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
    new Float:health,
		Float:armour;

	GetPlayerHealth(damagedid, health);
	GetPlayerArmour(damagedid, armour);
    if(weaponid == 9 && pData[playerid][pAdmin] < 1)
    {
	    if(pData[playerid][pChainshaw] < 1)
	    {
		    pData[playerid][pChainshaw]++;
		    SetPlayerHealth(damagedid, health);
		    SetPlayerArmour(damagedid, armour);
			amount = 0.0; 
		}
		else
		{
		    SendClientMessageToAllEx(COLOR_LIGHTRED, "BotCmd: %s has been kicked from the server, reason: Abusing Chainsaw!", GetName(playerid));
			KickEx(playerid);
		}
	}
	else if(weaponid == 0 && pData[playerid][pAdmin] < 1)// Weapon ID 0 usually represents unarmed (tangan kosong)
    {
		if(pData[playerid][pLevel] < 3)
	    if(pData[damagedid][pHandHits] < 5) // Anti hit van 5x
	    {
		    pData[damagedid][pHandHits]++;
		    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Anti hit", "Kamu masih level rendah tidak bisa memukul Sembarangan\nPerigatan ke 5 Anda akan di kick Oleh Bot", "Okey", "");
		    SetPlayerHealth(damagedid, health);
		    SetPlayerArmour(damagedid, armour);
		    amount = 0.0;
	    }
	    else
	    {
		    SendClientMessageToAllEx(COLOR_LIGHTRED, "BotCmd: %s has been kicked from the server, reason: Dibawah Level 3, Memukul Player lain lebih dari 5x!", GetName(playerid));
		    KickEx(playerid);
	    }
    }
    return 1;
}

public OnPlayerUpdate(playerid)
{

	pData[playerid][pLastUpdate] = gettime();

	static str[500], stro[500];
	if (PlayerInfo[playerid][pWaypoint])
	{
		format(str, sizeof(str), "%s", PlayerInfo[playerid][pLocation]);		
		PlayerTextDrawSetString(playerid, lokasigps[playerid], str);
		format(stro, sizeof(stro), "(%.2f meters)", GetPlayerDistanceFromPoint(playerid, PlayerInfo[playerid][pWaypointPos][0], PlayerInfo[playerid][pWaypointPos][1], PlayerInfo[playerid][pWaypointPos][2]));
		PlayerTextDrawSetString(playerid, valuegps[playerid], stro);
	}
	//spawn1jam
    if(pData[playerid][pDelaySpawn] > 0)
	{
		pData[playerid][pDelaySpawn]--;
	}	
	//SAPD Tazer/Taser
	GetSpeedCam(playerid);
	UpdateTazer(playerid);
	//SavePeluru(playerid);
	p_tick[playerid]++;
	//SAPD Road Spike
	CheckPlayerInSpike(playerid);
	//hapetelponnyarr
	new string[256];
 	foreach(new ii : Player)
	{
		if(playerid == pData[ii][pCall])
		{
			format(string, sizeof(string), "%02d:%02d:%02d", JamCall[ii], MenitCall[ii], DetikCall[ii]);
			PlayerTextDrawSetString(ii, CallHpLenz[ii][17], string);

			format(string, sizeof(string), "%02d:%02d:%02d", JamCall[playerid], MenitCall[playerid], DetikCall[playerid]);
			PlayerTextDrawSetString(playerid, CallHpLenz[playerid][17], string);
		}
	}
	//AntiCheat
	pData[playerid][pLastUpdate] = gettime();
	if(noclipdata[playerid][cameramode] == CAMERA_MODE_FLY)
	{
		new keys,ud,lr;
		GetPlayerKeys(playerid,keys,ud,lr);

		if(noclipdata[playerid][mode] && (GetTickCount() - noclipdata[playerid][lastmove] > 100))
		{
		    // If the last move was > 100ms ago, process moving the object the players camera is attached to
		    MoveCamera(playerid);
		}

		// Is the players current key state different than their last keystate?
		if(noclipdata[playerid][udold] != ud || noclipdata[playerid][lrold] != lr)
		{
			if((noclipdata[playerid][udold] != 0 || noclipdata[playerid][lrold] != 0) && ud == 0 && lr == 0)
			{   // All keys have been released, stop the object the camera is attached to and reset the acceleration multiplier
				StopPlayerObject(playerid, noclipdata[playerid][flyobject]);
				noclipdata[playerid][mode]      = 0;
				noclipdata[playerid][accelmul]  = 0.0;
			}
			else
			{   // Indicates a new key has been pressed

			    // Get the direction the player wants to move as indicated by the keys
				noclipdata[playerid][mode] = GetMoveDirectionFromKeys(ud, lr);

				// Process moving the object the players camera is attached to
				MoveCamera(playerid);
			}
		}
		noclipdata[playerid][udold] = ud; noclipdata[playerid][lrold] = lr; // Store current keys pressed for comparison next update
		return 0;
	}
	if(pData[playerid][pCharacterStory] < 1)
	{
		if(GetPlayerWeapon(playerid) > 18 && GetPlayerWeapon(playerid) < 39)
		{
			ResetWeapon(playerid, 22);
			ResetWeapon(playerid, 23);
			ResetWeapon(playerid, 24);
			ResetWeapon(playerid, 25);
			ResetWeapon(playerid, 26);
			ResetWeapon(playerid, 27);
			ResetWeapon(playerid, 28);
			ResetWeapon(playerid, 30);
			ResetWeapon(playerid, 31);
			ResetWeapon(playerid, 32);
			ResetWeapon(playerid, 33);
			ResetWeapon(playerid, 34);
			ResetWeapon(playerid, 35);
			ResetWeapon(playerid, 36);
			ResetWeapon(playerid, 37);
			ResetWeapon(playerid, 38);
		}
	}
	return 1;
}

task VehicleUpdate[40000]()
{
	for (new i = 1; i != MAX_VEHICLES; i ++) if(IsEngineVehicle(i) && GetEngineStatus(i))
    {
        if(GetVehicleFuel(i) > 0)
        {
			new fuel = GetVehicleFuel(i);
            SetVehicleFuel(i, fuel - 20);

            if(GetVehicleFuel(i) >= 1 && GetVehicleFuel(i) <= 200)
            {
               Info(GetVehicleDriver(i), "Kendaraan ingin habis bensin, Harap pergi ke SPBU ( Gas Station )");
            }
        }
        if(GetVehicleFuel(i) <= 0)
        {
            SetVehicleFuel(i, 0);
            SwitchVehicleEngine(i, false);
        }
    }
	foreach(new ii : PVehicles)
	{
		if(IsValidVehicle(pvData[ii][cVeh]))
		{
			//Vehicle_StorageSave(ii);
			if(pvData[ii][cPlateTime] != 0 && pvData[ii][cPlateTime] <= gettime())
			{
				format(pvData[ii][cPlate], 32, "NoHave");
				SetVehicleNumberPlate(pvData[ii][cVeh], pvData[ii][cPlate]);
				pvData[ii][cPlateTime] = 0;
			}
			if(pvData[ii][cRent] != 0 && pvData[ii][cRent] <= gettime())
			{
				pvData[ii][cRent] = 0;
				new query[128], xuery[128];
				mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", pvData[ii][cID]);
				mysql_tquery(g_SQL, query);

				mysql_format(g_SQL, xuery, sizeof(xuery), "DELETE FROM vstorage WHERE owner = '%d'", pvData[ii][cID]);
				mysql_tquery(g_SQL, xuery);
				if(IsValidVehicle(pvData[ii][cVeh])) DestroyVehicle(pvData[ii][cVeh]);
				pvData[ii][cVeh] = INVALID_VEHICLE_ID;
				Iter_SafeRemove(PVehicles, ii, ii);
			}
		}
		if(pvData[ii][cClaimTime] != 0 && pvData[ii][cClaimTime] <= gettime())
		{
			pvData[ii][cClaimTime] = 0;
		}
	}
}
public OnVehicleDeath(vehicleid, killerid)
{
	foreach(new i : PVehicles)
    {
        if(pvData[i][cVeh] == vehicleid)
        {
            pvData[i][cStolen] = gettime() + 15;
            foreach(new pid : Player) if (pvData[i][cOwner] == pData[pid][pID])
            {
             	Info(pid, "{FFFF00}Kendaraan Anda telah di hancurkan Oleh {FFFFFF}(%d) %s", killerid, pData[killerid][pName]);   
            }
        }
    }
    return 1;
}

public OnVehicleSpawn(vehicleid)
{
	foreach(new i : Player)
	{
		if(pData[i][pFactionVeh] == vehicleid)
		{
			DestroyVehicle(pData[i][pFactionVeh]);
			pData[i][pFactionVeh] = INVALID_VEHICLE_ID;
			pData[i][pFactionVeh] = 0;
		}
	}
	
    foreach(new ii : PVehicles)
    {
        if(vehicleid == pvData[ii][cVeh] && pvData[ii][cRent] == 0 && pvData[ii][cStolen] > gettime())
        {
            if(pvData[ii][cInsu] > 0)
            {
                pvData[ii][cStolen] = 0;
				pvData[ii][cInsu]--;
                pvData[ii][cClaim] = 1;
                pvData[ii][cClaimTime] = gettime() + (1 * 60);
                foreach(new pid : Player) if (pvData[ii][cOwner] == pData[pid][pID])
                {
                    Info(pid, "Kendaraan anda hancur, silahkan ambil di kantor insurance.");
                }
            }
            if(IsValidVehicle(pvData[ii][cVeh])) DestroyVehicle(pvData[ii][cVeh]);
			pvData[ii][cVeh] = INVALID_VEHICLE_ID;
			//Iter_SafeRemove(PVehicles, ii, ii);
        }
    }
	if(AdminVehicle{vehicleid})
	{
	    DestroyVehicle(vehicleid);
	    AdminVehicle{vehicleid} = false;
	}
    return 1;
}
ptask BrakeUpdate[250](playerid)
{
    new a, b, c;
	GetPlayerKeys(playerid, a, b ,c);
	new vehicleid = GetPlayerVehicleID(playerid);
	new Float:speed = GetVehicleSpeedKMH(vehicleid);

	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && !IsVehicleBackwordsDirection(vehicleid) && speed >= 30.0)
	{
	    foreach(new i : PVehicles)
	    {
	        if(vehicleid == pvData[i][cVeh] && pvData[i][cUpgrade][3] != 0)
			{
				//if(a == KEY_HANDBRAKE || a == KEY_JUMP)
				if(a == KEY_LOOK_BEHIND)
				{
				    SetVehSpeed(vehicleid, speed- (10.0 * pvData[i][cUpgrade][3]));
				}
			}
		}
	}
	return 1;
}

ptask TurboUpdate[5000](playerid)
{
    new a, b, c;
	GetPlayerKeys(playerid, a, b ,c);
	new vehicleid = GetPlayerVehicleID(playerid);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	    foreach(new i : PVehicles)
	    {
	        if(vehicleid == pvData[i][cVeh] && pvData[i][cUpgrade][2] != 0 && !IsVehicleBackwordsDirection(pvData[i][cVeh]))
			{
				if(a == KEY_SPRINT && GetVehicleSpeedKMH(pvData[i][cVeh]) >= 50.0)
				{
					new Float:D[4], Float:dis;
					switch(pvData[i][cUpgrade][2])
					{
					    case 1: dis = 0.10;
					    case 2: dis = 0.20;
					    case 3: dis = 0.30;
					}
					GetVehicleVelocity(pvData[i][cVeh], D[0], D[1], D[2]);
					GetVehicleZAngle(pvData[i][cVeh], D[3]);
					SetVehicleVelocity(pvData[i][cVeh], floatadd(D[0],floatmul(dis,floatsin(-D[3],degrees))), floatadd(D[1],floatmul(dis,floatcos(-D[3],degrees))), D[2]);
				}
			}
		}
	}
	return 1;
}

ptask PlayerVehicleUpdate[200](playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsValidVehicle(vehicleid))
	{
		if(!GetEngineStatus(vehicleid) && IsEngineVehicle(vehicleid))
		{	
			SwitchVehicleEngine(vehicleid, false);
		}
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			new Float:fHealth;
			GetVehicleHealth(vehicleid, fHealth);
			if(IsValidVehicle(vehicleid) && fHealth <= 350.0)
			{
				SetValidVehicleHealth(vehicleid, 300.0);
				SwitchVehicleEngine(vehicleid, false);
				InfoTD_MSG(playerid, 2500, "~r~Totalled");
			}
		}
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			if(pData[playerid][pHBEMode] == 1)
			{
            	new Float:fDamage, fFuel, color1, color2;
				new str[999];

				new datestring[64];
				new hours,
				minutes,
				seconds;
				gettime(hours, minutes, seconds);

		    	new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);

				GetVehicleColor(vehicleid, color1, color2);

				GetVehicleHealth(vehicleid, fDamage);
				if(fDamage <= 350) fDamage = 0;
				else if(fDamage > 5000) fDamage = 5000;
				
				fFuel = GetVehicleFuel(vehicleid);
				if(fFuel < 0) fFuel = 0;
				else if(fFuel > 1000) fFuel = 1000;
				//engine
				if(!GetEngineStatus(vehicleid))
				{
					PlayerTextDrawSetString(playerid, enginehud[playerid], "OFF");
				}
				else
				{
					PlayerTextDrawSetString(playerid, enginehud[playerid], "ON");
				}
				//gpslokasi
				format(str, sizeof(str), "%s", GetLocation(x, y, z));
	       		PlayerTextDrawSetString(playerid, gpshud[playerid], str);
				//kecepatan
				format(str, sizeof(str), "%.0f", GetVehicleSpeed(vehicleid));
				PlayerTextDrawSetString(playerid, banterhud[playerid], str);
				//damageveh
                format(str, sizeof(str), "%.0f", fDamage);
                PlayerTextDrawSetString(playerid, nyowohud[playerid], str);
				//bensine
  				format(str, sizeof(str), "%d", fFuel / 10);
   				PlayerTextDrawSetString(playerid, bensinhud[playerid], str);	
				//namamobil		
				format(str, sizeof(str), "%s", GetVehicleName(vehicleid));
				PlayerTextDrawSetString(playerid, mobilhud[playerid], str);
				//Hudveh
				format(datestring, sizeof datestring, "%s%d:%s%d:%s%d", (hours < 10) ? ("0") : (""), hours, (minutes < 10) ? ("0") : (""), minutes, (seconds < 10) ? ("0") : (""), seconds);
				PlayerTextDrawSetString(playerid, jamhud[playerid], datestring);
				new Float:rz;
				if(IsPlayerInAnyVehicle(playerid))
				{
					GetVehicleZAngle(GetPlayerVehicleID(playerid), rz);
				}
				else
				{
					GetPlayerFacingAngle(playerid, rz);
				}

				if(rz >= 348.75 || rz < 11.25) PlayerTextDrawSetString(playerid, mataangin[playerid], "N");
				else if(rz >= 326.25 && rz < 348.75) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
				else if(rz >= 303.75 && rz < 326.25) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
				else if(rz >= 281.25 && rz < 303.75) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
				else if(rz >= 258.75 && rz < 281.25) PlayerTextDrawSetString(playerid, mataangin[playerid], "E");
				else if(rz >= 236.25 && rz < 258.75) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
				else if(rz >= 213.75 && rz < 236.25) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
				else if(rz >= 191.25 && rz < 213.75) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
				else if(rz >= 168.75 && rz < 191.25) PlayerTextDrawSetString(playerid, mataangin[playerid], "S");
				else if(rz >= 146.25 && rz < 168.75) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
				else if(rz >= 123.25 && rz < 146.25) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
				else if(rz >= 101.25 && rz < 123.25) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
				else if(rz >= 78.75 && rz < 101.25) PlayerTextDrawSetString(playerid, mataangin[playerid], "W");
				else if(rz >= 56.25 && rz < 78.75) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
				else if(rz >= 33.75 && rz < 56.25) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
				else if(rz >= 11.5 && rz < 33.75) PlayerTextDrawSetString(playerid, mataangin[playerid], "!");
			}
			if(pData[playerid][pHBEMode] == 2)
			{
				new Float:fDamage, fFuel, color1, color2;
				new str[999];

				new datestring[64];
				new hours,
				minutes,
				seconds;
				gettime(hours, minutes, seconds);

				GetVehicleColor(vehicleid, color1, color2);

				GetVehicleHealth(vehicleid, fDamage);
				if(fDamage <= 350) fDamage = 0;
				else if(fDamage > 5000) fDamage = 5000;
				
				fFuel = GetVehicleFuel(vehicleid);
				if(fFuel < 0) fFuel = 0;
				else if(fFuel > 1000) fFuel = 1000;

				//kecepatan
				format(str, sizeof(str), "%.0f", GetVehicleSpeed(vehicleid));
				PlayerTextDrawSetString(playerid, KecepatanTry[playerid], str);
				//damage
				format(str, sizeof(str), "%.0f", fDamage);
				PlayerTextDrawSetString(playerid, DamageTry[playerid], str);
				//fuel
				format(str, sizeof(str), "%d", fFuel / 10);
				PlayerTextDrawSetString(playerid, BensinTry[playerid], str);	
				//jenismobil
				//PlayerTextDrawSetPreviewModel(playerid, SultanTry[playerid], GetVehicleModel(GetPlayerVehicleID(playerid)));
				//PlayerTextDrawSetPreviewVehCol(playerid, SultanTry[playerid], color1, color2);
				//jam
				format(datestring, sizeof datestring, "%s%d:%s%d:%s%d", (hours < 10) ? ("0") : (""), hours, (minutes < 10) ? ("0") : (""), minutes, (seconds < 10) ? ("0") : (""), seconds);
				PlayerTextDrawSetString(playerid, JamTry[playerid], datestring);
			}
		}
	}
}

ptask PlayerUpdate[999](playerid)
{
    //JOB BUS
	if(pData[playerid][pBus] && IsABusVeh(GetPlayerVehicleID(playerid)) && pData[playerid][pBuswaiting])
	{
		if(pData[playerid][pBustime] > 0)
		{
			pData[playerid][pBustime]--;
			new str[512];
			format(str, sizeof(str), "Mohon Tunggu Selama %d Detik Untuk Melakukan Perjalanan", pData[playerid][pBustime]);
			InfoTD_MSG(playerid, 1000, str);
		}
		else
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.0, 683.9858, -1149.5016, 15.5493))
			{
				pData[playerid][pBuswaiting] = false;
				pData[playerid][pBustime] = 0;
				pData[playerid][pBus] = 16;
				DisablePlayerRaceCheckpoint(playerid);
				SetPlayerRaceCheckpoint(playerid, 2, buspoint16, buspoint16, 5.0);
				PlayerPlaySound(playerid, 43000, 0.0,0.0,0.0);
			}
			else if(IsPlayerInRangeOfPoint(playerid, 2.0, 20.0027, -495.0953, 7.9860))
			{
				pData[playerid][pBuswaiting] = false;
				pData[playerid][pBustime] = 0;
				pData[playerid][pBus] = 27;
				DisablePlayerRaceCheckpoint(playerid);
				SetPlayerRaceCheckpoint(playerid, 1, buspoint27, buspoint27, 5.0);
				PlayerPlaySound(playerid, 43000, 0.0,0.0,0.0);
			}
			else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1481.4166, -1870.2290, 13.4840))
			{
				pData[playerid][pBuswaiting] = false;
				pData[playerid][pBustime] = 0;
				pData[playerid][pBus] = 59;
				DisablePlayerRaceCheckpoint(playerid);
				SetPlayerRaceCheckpoint(playerid, 1, buspoint59, buspoint59, 5.0);
				PlayerPlaySound(playerid, 43000, 0.0,0.0,0.0);
			}
		}
	}
	if(pData[playerid][pRestart] > 0)
    {
		new mstr[64];
		pData[playerid][pRestart]--;
        format(mstr, sizeof(mstr), "%d DETIK", pData[playerid][pRestart]);
        //InfoTD_MSG(playerid, 1000, mstr);
		TextDrawSetString(BadaiInfo[9], mstr);
	}
    if(pData[playerid][TempatHealing])
    {
        stresstimer[playerid] = SetTimerEx("StressBerkurang", 5000, true, "d", playerid);
    }
    if(pData[playerid][pBladder] <= 15)
    {
        pData[playerid][TempatHealing] = false;
        KillTimer(stresstimer[playerid]);
    }
    //vending update
	PlayerVendingUpdate(playerid);
	//antiplayer ritat
	if(pData[playerid][pLevel] < 5)
	{
 		if(GetPlayerWeapon(playerid) >= 10 && GetPlayerWeapon(playerid) != 46)
 		ResetPlayerWeaponsEx(playerid);
		//SendClientMessage(playerid, -1, "Kamu Belum Waktunya Untuk Membawa Senjata!!!"); 
	}
	if(GetPlayerScore(playerid) < 5)//artinya kalau level dibawah 2 bakalan ke kick terkena anti cheat weapon hack
 	{
		if(GetPlayerWeapon(playerid) == 10)//id 25 sama dengan senjata shotgun
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 11)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 12)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 13)
		{
			ResetPlayerWeaponsEx(playerid);
		}
		if(GetPlayerWeapon(playerid) == 14)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 15)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 16)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
        if(GetPlayerWeapon(playerid) == 17)//id 38 sama dengan senjata minigun
		{	
			ResetPlayerWeaponsEx(playerid); 
		}
		if(GetPlayerWeapon(playerid) == 18)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 19)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 20)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 21)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 22)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 23)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 24)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 25)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 26)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 27)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 28)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 29)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 30)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 32)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 32)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 33)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 34)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 35)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 36)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 37)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 38)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 39)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
		if(GetPlayerWeapon(playerid) == 40)
		{
			ResetPlayerWeaponsEx(playerid);   
		}
	}
    if(pData[playerid][pAdmin] == 5)//ini adalah variable yang mengget varibale player apa bila bukan admin dia akan terkena kick weapon hack
	{
        if(GetPlayerWeapon(playerid) == 38)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Gausah Abuse Ngentod!!!"); 
		   	Kick(playerid);
		}
	}
	if(pData[playerid][pFaction] == 5)
	{
        if(GetPlayerWeapon(playerid) == 22)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu Pedagang Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 23)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu Pedagang Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 24)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu Pedagang Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 25)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu Pedagang Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 26)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu Pedagang Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 27)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu Pedagang Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 28)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu Pedagang Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 29)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu Pedagang Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 30)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu Pedagang Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 31)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu Pedagang Bukan Badside Bodo!!!"); 
		}
	}
	if(pData[playerid][pFaction] == 4)
	{
        if(GetPlayerWeapon(playerid) == 22)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu SANEWS Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 23)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu SANEWS Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 24)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu SANEWS Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 25)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu SANEWS Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 26)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu SANEWS Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 27)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu SANEWS Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 28)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu SANEWS Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 29)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu SANEWS Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 30)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu SANEWS Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 31)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu SANEWS Bukan Badside Bodo!!!"); 
		}
	}
	if(pData[playerid][pFaction] == 3)
	{
        if(GetPlayerWeapon(playerid) == 22)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu Medical Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 23)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu Medical Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 24)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu Medical Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 25)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu Medical Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 26)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu Medical Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 27)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu Medical Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 28)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu Medical Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 29)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu Medical Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 30)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu Medical Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 31)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu Medical Bukan Badside Bodo!!!"); 
		}
	}
	if(pData[playerid][pFaction] == 2)
	{
        if(GetPlayerWeapon(playerid) == 22)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu SAGS Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 23)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu SAGS Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 24)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu SAGS Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 25)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu SAGS Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 26)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu SAGS Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 27)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu SAGS Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 28)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu SAGS Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 29)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu SAGS Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 30)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu SAGS Bukan Badside Bodo!!!"); 
		}
        if(GetPlayerWeapon(playerid) == 31)
		{
			ResetPlayerWeaponsEx(playerid);
			SendClientMessage(playerid, -1, "Kamu Itu SAGS Bukan Badside Bodo!!!"); 
		}
	}
	//Anti-Cheat Vehicle health hack
	if(pData[playerid][pAdmin] < 2)
	{
		for(new v, j = MAX_VEHICLES; v <= j; v++) if(GetVehicleModel(v))
		{
			new Float:health;
			GetVehicleHealth(v, health);
			if( (health > VehicleHealthSecurityData[v]) && VehicleHealthSecurity[v] == false)
			{
				if(GetPlayerVehicleID(playerid) == v)
				{
					new playerState = GetPlayerState(playerid);
					if(playerState == PLAYER_STATE_DRIVER)
					{
						SetValidVehicleHealth(v, VehicleHealthSecurityData[v]);
						SendClientMessageToAllEx(COLOR_RED, "[ANTICHEAT]: "GREY2_E"%s terdeteksi telah menggunakan health hack!", pData[playerid][pName]);
						KickEx(playerid);
					}
				}
			}
			if(VehicleHealthSecurity[v] == true)
			{
				VehicleHealthSecurity[v] = false;
			}
			VehicleHealthSecurityData[v] = health;
		}
	}	
	//Anti-Money Hack
	if(GetPlayerMoney(playerid) > pData[playerid][pMoney])
	{
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid, pData[playerid][pMoney]);
		//SendAdminMessage(COLOR_RED, "Possible money hacks detected on %s(%i). Check on this player. "LG_E"($%d).", pData[playerid][pName], playerid, GetPlayerMoney(playerid) - pData[playerid][pMoney]);
	}
	//Anti Armour Hacks
	new Float:A;
	GetPlayerArmour(playerid, A);
	if(pData[playerid][pAdmin] < 2)
	{
		if(A > 98)
		{
			SetPlayerArmourEx(playerid, 0);
			SendAdminMessage(COLOR_RED, "[ANTICHEAT]: "GREY2_E"%s(%i) Possible armour hacks!", pData[playerid][pName], playerid);
		}
	}
	//Weapon AC
	if(pData[playerid][pAdmin] < 2)
	{
		if(pData[playerid][pSpawned] == 1)
		{
			if(GetPlayerWeapon(playerid) != pData[playerid][pWeapon])
			{
				pData[playerid][pWeapon] = GetPlayerWeapon(playerid);
				//if(pData[playerid][pWeapon] >= 1 && pData[playerid][pWeapon] <= 45 && pData[playerid][pWeapon] != 40 && pData[playerid][pWeapon] != 2 && pData[playerid][pGuns][g_aWeaponSlots[pData[playerid][pWeapon]]] != GetPlayerWeapon(playerid))

				if(pData[playerid][pWeapon] >= 1 && pData[playerid][pWeapon] <= 45 && pData[playerid][pGuns][g_aWeaponSlots[pData[playerid][pWeapon]]] != GetPlayerWeapon(playerid))
				{
					pData[playerid][pACWarns]++;

					if(pData[playerid][pACWarns] < MAX_ANTICHEAT_WARNINGS)
					{
						SendAnticheat(COLOR_RED, "%s(%d) has possibly used weapon hacks (%s), Please to check /spec this player first!", pData[playerid][pName], playerid, ReturnWeaponName(pData[playerid][pWeapon]));
						SetWeapons(playerid);
					}
					else
					{
						new PlayerIP[16];
						SendStaffMessage(COLOR_RED, "{DDA0DD}%s"WHITE_E" telah dibanned otomatis oleh %s, Alasan: Weapon hacks", pData[playerid][pName], SERVER_BOT);

						GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
						new query[300], tmp[40], ban_time = 0;
						format(tmp, sizeof (tmp), "Weapon Hack (%s)", ReturnWeaponName(pData[playerid][pWeapon]));
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO banneds(name, ip, admin, reason, ban_date, ban_expire) VALUES ('%s', '%s', '%s', '%s', %i, %d)", pData[playerid][pUCP], PlayerIP, SERVER_BOT, tmp, gettime(), ban_time);
						mysql_tquery(g_SQL, query);
						KickEx(playerid);
					}
				}
			}
		}
	}	
	if(pData[playerid][pSpawned] == 1)
    {
        if(GetPlayerWeapon(playerid) != pData[playerid][pWeapon])
        {
            pData[playerid][pWeapon] = GetPlayerWeapon(playerid);

            if(pData[playerid][pWeapon] >= 1 && pData[playerid][pWeapon] <= 45 && pData[playerid][pWeapon] != 42 && pData[playerid][pWeapon] != 2 && pData[playerid][pGuns][g_aWeaponSlots[pData[playerid][pWeapon]]] != GetPlayerWeapon(playerid))
			{
               // SendAnticheat(COLOR_YELLOW, "%s (%d) has possibly used weapon hacks (%s), Please to check /spec this player first!", pData[playerid][pName], playerid, ReturnWeaponName(pData[playerid][pWeapon]));
               // SetWeapons(playerid); //Reload old weapons
				SendClientMessageToAllEx(COLOR_LIGHTRED, "[Anticheat] {ffffff}%s telah di keluarkan dari server, Reason: Weapon Hacks! (%s)", ReturnName(playerid));
				SendClientMessageToAllEx(COLOR_WHITE, "Alasan ~> Weapon Hacks (%s)", ReturnWeaponName(PlayerData[playerid][pWeapon]));
				SetWeapons(playerid);
				KickEx(playerid);
            }
        }
    }
	//Weapon Atth
	if(NetStats_GetConnectedTime(playerid) - WeaponTick[playerid] >= 250)
	{
		static weaponid, ammo, objectslot, count, index;
 
		for (new i = 2; i <= 7; i++) //Loop only through the slots that may contain the wearable weapons
		{
			GetPlayerWeaponData(playerid, i, weaponid, ammo);
			index = weaponid - 22;
		   
			if (weaponid && ammo && !WeaponSettings[playerid][index][Hidden] && IsWeaponWearable(weaponid) && EditingWeapon[playerid] != weaponid)
			{
				objectslot = GetWeaponObjectSlot(weaponid);
 
				if (GetPlayerWeapon(playerid) != weaponid)
					SetPlayerAttachedObject(playerid, objectslot, GetWeaponModel(weaponid), WeaponSettings[playerid][index][Bone], WeaponSettings[playerid][index][Position][0], WeaponSettings[playerid][index][Position][1], WeaponSettings[playerid][index][Position][2], WeaponSettings[playerid][index][Position][3], WeaponSettings[playerid][index][Position][4], WeaponSettings[playerid][index][Position][5], 1.0, 1.0, 1.0);
 
				else if (IsPlayerAttachedObjectSlotUsed(playerid, objectslot)) RemovePlayerAttachedObject(playerid, objectslot);
			}
		}
		for (new i = 4; i <= 8; i++) if (IsPlayerAttachedObjectSlotUsed(playerid, i))
		{
			count = 0;
 
			for (new j = 22; j <= 38; j++) if (PlayerHasWeapon(playerid, j) && GetWeaponObjectSlot(j) == i)
				count++;
 
			if(!count) RemovePlayerAttachedObject(playerid, i);
		}
		WeaponTick[playerid] = NetStats_GetConnectedTime(playerid);
	}
	
	//Player Update Online Data
	//GetPlayerHealth(playerid, pData[playerid][pHealth]);
    //GetPlayerArmour(playerid, pData[playerid][pArmour]);
	
	if(pData[playerid][pJail] <= 0)
	{
		if(pData[playerid][pHunger] > 100)
		{
			pData[playerid][pHunger] = 100;
		}
		if(pData[playerid][pHunger] < 0)
		{
			pData[playerid][pHunger] = 0;
		}
		if(pData[playerid][pEnergy] > 100)
		{
			pData[playerid][pEnergy] = 100;
		}
		if(pData[playerid][pEnergy] < 0)
		{
			pData[playerid][pEnergy] = 0;
		}
		if(pData[playerid][pBladder] > 100)
		{
			pData[playerid][pBladder] = 100;
		}
		if(pData[playerid][pBladder] < 0)
		{
			pData[playerid][pBladder] = 0;
		}
		if(pData[playerid][pDelayWT] < 0)
		{
			pData[playerid][pDelayWT] = 0;
		}
		if(pData[playerid][pHead] < 0)
		{
			pData[playerid][pHead] = 0;
		}
		if(pData[playerid][pPerut] < 0)
		{
			pData[playerid][pPerut] = 0;
		}
		if(pData[playerid][pRHand] < 0)
		{
			pData[playerid][pRHand] = 0;
		}
		if(pData[playerid][pLHand] < 0)
		{
			pData[playerid][pLHand] = 0;
		}
		if(pData[playerid][pRFoot] < 0)
		{
			pData[playerid][pRFoot] = 0;
		}
		if(pData[playerid][pLFoot] < 0)
		{
			pData[playerid][pLFoot] = 0;
		}
		/*if(pData[playerid][pHealth] > 100)
		{
			SetPlayerHealthEx(playerid, 100);
		}*/
	}
	if(pData[playerid][pHBEMode] == 3 && pData[playerid][IsLoggedIn] == true)
	{
		new LenzPro[1000];
	    format(LenzPro, 250, "%d%", pData[playerid][pHunger]);
	    TextDrawSetString(HbeOprp[3], LenzPro);
	    TextDrawShowForPlayer(playerid, HbeOprp[3]);

	    format(LenzPro, 250, "%d%", pData[playerid][pEnergy]);
	    TextDrawSetString(HbeOprp[9], LenzPro);
	    TextDrawShowForPlayer(playerid, HbeOprp[9]);

	    format(LenzPro, 250, "%d%", pData[playerid][pBladder]);
	    TextDrawSetString(HbeOprp[11], LenzPro);
	    TextDrawShowForPlayer(playerid, HbeOprp[11]);
	}
	if(pData[playerid][pHBEMode] == 1 && pData[playerid][IsLoggedIn] == true)
	{
		/*new LenzPro[1000];
	    format(LenzPro, 250, "%d", pData[playerid][pHunger]);
	    PlayerTextDrawSetString(playerid, makan[playerid], LenzPro);
	    PlayerTextDrawShow(playerid, makan[playerid]);

	    format(LenzPro, 250, "%d", pData[playerid][pEnergy]);
	    PlayerTextDrawSetString(playerid, minum[playerid], LenzPro);
	    PlayerTextDrawShow(playerid, minum[playerid]);

	    format(LenzPro, 250, "%d", pData[playerid][pBladder]);
	    PlayerTextDrawSetString(playerid, stress[playerid], LenzPro);
	    PlayerTextDrawShow(playerid, stress[playerid]);*/
		new LenzPro[1000];
	    format(LenzPro, 250, "%d", pData[playerid][pHunger]);
	    PlayerTextDrawSetString(playerid, manganhud[playerid], LenzPro);
	    PlayerTextDrawShow(playerid, manganhud[playerid]);

	    format(LenzPro, 250, "%d", pData[playerid][pEnergy]);
	    PlayerTextDrawSetString(playerid, ombenhud[playerid], LenzPro);
	    PlayerTextDrawShow(playerid, ombenhud[playerid]);

	    format(LenzPro, 250, "%d", pData[playerid][pBladder]);
	    PlayerTextDrawSetString(playerid, stresshud[playerid], LenzPro);
	    PlayerTextDrawShow(playerid, stresshud[playerid]);

	    format(LenzPro, 250, "%s", FormatMoney(pData[playerid][pMoney]));
	    PlayerTextDrawSetString(playerid, duikhud[playerid], LenzPro);
	    PlayerTextDrawShow(playerid, duikhud[playerid]);


		format(LenzPro, 250, "%dms", GetPlayerPing(playerid));
		PlayerTextDrawSetString(playerid, sinyalhud[playerid], LenzPro);
		PlayerTextDrawShow(playerid, sinyalhud[playerid]);
	}
	if(pData[playerid][pHBEMode] == 2)
	{
		new LenzPro[1000];

		format(LenzPro, 250, "%d", pData[playerid][pHunger]);
	    PlayerTextDrawSetString(playerid, MakanTry[playerid], LenzPro);
	    PlayerTextDrawShow(playerid, MakanTry[playerid]);

	    format(LenzPro, 250, "%d", pData[playerid][pEnergy]);
	    PlayerTextDrawSetString(playerid, MinumTry[playerid], LenzPro);
	    PlayerTextDrawShow(playerid, MinumTry[playerid]);

	    format(LenzPro, 250, "%d", pData[playerid][pBladder]);
	    PlayerTextDrawSetString(playerid, StressTry[playerid], LenzPro);
	    PlayerTextDrawShow(playerid, StressTry[playerid]);
	}
	
	if(pData[playerid][pHospital] == 1)
    {
		if(pData[playerid][pInjured] == 1)
		{
			SetPlayerPosition(playerid, 1343.4487, 1566.1991, 23223.7344, 1);
		
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, playerid + 100);

			SetPlayerCameraPos(playerid, 1343.3635, 1563.6377, 23223.0859);
			SetPlayerCameraLookAt(playerid, 1343.3635, 1563.6377, 23223.0859);
			TogglePlayerControllable(playerid, 0);
			pData[playerid][pInjured] = 0;
			UpdateDynamic3DTextLabelText(pData[playerid][pInjuredLabel], COLOR_ORANGE, "");
			if(pData[playerid][pWeaponLic] != 1)
			{
				pData[playerid][pMarijuana] = 0;
				pData[playerid][pRedMoney] = 0;
				pData[playerid][pRokok] = 0;
				pData[playerid][pClipA] = 0;
				pData[playerid][pClipB] = 0;
				pData[playerid][pClipC] = 0;
				pData[playerid][pBlindfold] = 0;
				pData[playerid][pBoombox] = 0;
				pData[playerid][pMicin] = 0;
				pData[playerid][pPaketMicin] = 0;
				pData[playerid][pMaterial] = 0;
				pData[playerid][pComponent] = 0;
				ResetPlayerWeaponsEx(playerid);
			}
		}
		pData[playerid][pHospitalTime]++;
		new mstr[64];
		format(mstr, sizeof(mstr), "Recovering... %d", 15 - pData[playerid][pHospitalTime]);
		InfoTD_MSG(playerid, 1000, mstr);

		ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
		ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
        if(pData[playerid][pHospitalTime] >= 15)
        {
            pData[playerid][pHospitalTime] = 0;
            pData[playerid][pHospital] = 0;
			pData[playerid][pHunger] = 50;
			pData[playerid][pEnergy] = 50;
			pData[playerid][pBladder] = 50;
			SetPlayerHealthEx(playerid, 50);
			pData[playerid][pSick] = 0;
			GivePlayerMoneyEx(playerid, -300);
			ShowItemBox(playerid, "Uang", "Removed_$300", 1212, 4);
			SetPlayerHealthEx(playerid, 50);
			HideTdDeath(playerid);

            for (new i; i < 20; i++)
            {
                SendClientMessage(playerid, -1, "");
            }

			SendClientMessage(playerid, COLOR_GREY, "--------------------------------------------------------------------------------------------------------");
            SendClientMessage(playerid, COLOR_PINK2, "Kamu telah keluar dari rumah sakit, kamu membayar $300 kerumah sakit.");
            SendClientMessage(playerid, COLOR_PINK2, "Barang Yang Kamu Bawa Sudah Hilang Karena Koma, sayangilah nyawa anda tetap hati hati dikota!.");
			SendClientMessage(playerid, COLOR_GREY, "--------------------------------------------------------------------------------------------------------");
			
			SetPlayerPosition(playerid, 1343.3635, 1563.6377, 23223.0859, 3.7271);

            TogglePlayerControllable(playerid, true);
            SetCameraBehindPlayer(playerid);

            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
			ClearAnimations(playerid);
			pData[playerid][pSpawned] = 1;
			SetPVarInt(playerid, "GiveUptime", -1);
		}
    }
	if(pData[playerid][pInjured] == 1 && pData[playerid][pHospital] != 1)
    {

		ShowTdDeath(playerid);

		if(GetPVarInt(playerid, "GiveUptime") == -1)
		{
			SetPVarInt(playerid, "GiveUptime", gettime());
		}
		
		if(GetPVarInt(playerid,"GiveUptime"))
        {
            if((gettime()-GetPVarInt(playerid, "GiveUptime")) > 300)
            {
                InfoMsg(playerid, "Gunakan '/death' Untuk Spawn Ke ASGH.");
                SetPVarInt(playerid, "GiveUptime", 0);
            }
        }
        ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.1, 1, 0, 0, 0, 0);
		//ApplyAnimation(playerid, "CRACK", "crckidle1",4.0, 1, 0, 0, 0, 0, 1);
		//ApplyAnimation(playerid, "CRACK", "crckidle1",4.0, 1, 0, 0, 0, 0, 1);
		//ApplyAnimation(playerid, "CRACK", "null", 4.0, 0, 0, 0, 1, 0, 1);
        //ApplyAnimation(playerid, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1);
        //ApplyAnimation(playerid, "CRACK", "null", 4.0, 0, 0, 0, 1, 0, 1);
        //ApplyAnimation(playerid, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1);
        SetPlayerHealthEx(playerid, 99999);
    }
	if(pData[playerid][pInjured] == 0 && pData[playerid][pGender] != 0) //Pengurangan Data
	{
		if (++pData[playerid][pHungerTime] >= 250)
		{
			if (pData[playerid][pHunger] > 0)
			{
				pData[playerid][pHunger]--;
				
				if (pData[playerid][pHunger] == 30)
				{
					InfoMsg(playerid, "Hati-hati! Kamu mulai merasa lapar.");
				}
			}
			else if (pData[playerid][pHunger] <= 0)
			{
				if (pData[playerid][pHunger] == 0)
				{
					InfoMsg(playerid, "Kamu sangat lapar dan mulai merasa sakit.");
				}
				pData[playerid][pSick] = 1;
			}
			pData[playerid][pHungerTime] = 0;
		}
        if(++ pData[playerid][pEnergyTime] >= 240)
        {
            if(pData[playerid][pEnergy] > 0)
            {
                pData[playerid][pEnergy]--;

				if (pData[playerid][pEnergy] == 30)
				{
					InfoMsg(playerid, "Hati-hati! Kamu mulai merasa haus.");
				}
            }
            else if(pData[playerid][pEnergy] <= 0)
            {
				if (pData[playerid][pEnergy] == 0)
				{
					InfoMsg(playerid, "Kamu sangat haus dan mulai merasa sakit.");
				}
				pData[playerid][pSick] = 1;
            }
            pData[playerid][pEnergyTime] = 0;
        }
        if(++ pData[playerid][pBladderTime] >= 250)
        {
            if(pData[playerid][pBladder] > 0)
            {
                pData[playerid][pBladder]--;
            }
            else if(pData[playerid][pBladder] >= 70)
            {
				new Float:hp;
				GetPlayerHealth(playerid, hp);
                SetPlayerHealth(playerid, hp - 1);
				InfoMsg(playerid, "Anda Sedang Stress.");
          		SetPlayerDrunkLevel(playerid, 8000);
          		pData[playerid][pSick] = 1;
            }
            pData[playerid][pBladderTime] = 0;
        }

		if(pData[playerid][pSick] == 1)
		{
			if(++ pData[playerid][pSickTime] >= 200)
			{
				if(pData[playerid][pSick] >= 1)
				{
					new Float:hp;
					GetPlayerHealth(playerid, hp);
					SetPlayerDrunkLevel(playerid, 8000);
					ApplyAnimation(playerid,"CRACK","crckdeth2",4.1,0,1,1,1,1,1);
					//ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0, 1);
					InfoMsg(playerid, "Anda Sedang Sakit.");
					SetPlayerHealth(playerid, hp - 10);
					pData[playerid][pSickTime] = 0;
				}
			}
		}
	}
	/*if (pData[playerid][pSpeedTime] > 0)
	{
	    pData[playerid][pSpeedTime]--;
	}*/
	if(pData[playerid][pLastChopTime] > 0)
    {
		pData[playerid][pLastChopTime]--;
		new mstr[64];
        format(mstr, sizeof(mstr), "Waktu Pencurian %d detik", pData[playerid][pLastChopTime]);
        InfoTD_MSG(playerid, 1000, mstr);
	}
	//Jail Player
	if(pData[playerid][pJail] > 0)
	{
		if(pData[playerid][pJailTime] > 0)
		{
			pData[playerid][pJailTime]--;
			new mstr[128];
			format(mstr, sizeof(mstr), "You will be unjail in %d seconds.", pData[playerid][pJailTime]);
			InfoTD_MSG(playerid, 1000, mstr);
		}
		else
		{
			pData[playerid][pJail] = 0;
			pData[playerid][pJailTime] = 0;
			//SpawnPlayer(playerid);
			SetPlayerPositionEx(playerid, 1544.2949, -1675.2517, 13.5581, 750, 2000);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			SendClientMessageToAllEx(COLOR_RED, "Server: "GREY2_E" %s(%d) have been un-jailed by the server. (times up)", pData[playerid][pName], playerid);
		}
	}
	//Arreset Player
	if(pData[playerid][pArrest] > 0)
	{
		if(pData[playerid][pArrestTime] > 0)
		{
			pData[playerid][pArrestTime]--;
			new mstr[128];
			format(mstr, sizeof(mstr), "You will be released in %d seconds.", pData[playerid][pArrestTime]);
			InfoTD_MSG(playerid, 1000, mstr);

			hidePilihanSpawn(playerid);
		}
		else
		{
			pData[playerid][pArrest] = 0;
			pData[playerid][pArrestTime] = 0;
			//SpawnPlayer(playerid);
			//SetPlayerPositionEx(playerid, 1526.69, -1678.05, 5.89, 267.76, 2000);
			SetPlayerPositionEx(playerid, 1544.2949, -1675.2517, 13.5581, 750, 2000);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			InfoMsg(playerid, "You have been auto release. (times up)");
		}
	}
	//Twitter Post
	if(pData[playerid][pTwitterPostCooldown] > 0)
	{
		pData[playerid][pTwitterPostCooldown]--;
	}
	//Twitter Changename
	if(pData[playerid][pTwitterNameCooldown] > 0)
	{
		pData[playerid][pTwitterNameCooldown]--;
	}
}

forward AppuieJump(playerid);
public AppuieJump(playerid)
{
    AntiBHOP[playerid] = 0;
    ClearAnimations(playerid);
    return 1;
}
forward AppuiePasJump(playerid);
public AppuiePasJump(playerid)
{
    AntiBHOP[playerid] = 0;
    return 1;
}
public OnPlayerExitVehicle(playerid, vehicleid)
{
    if(pData[playerid][pDriveLicApp] > 0)
	{
		//new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 602)
		{
		    DisablePlayerCheckpoint(playerid);
			DisablePlayerRaceCheckpoint(playerid);
		    InfoMsg(playerid, "Anda Dengan Sengaja Keluar Dari Mobil Latihan, Anda Telah "RED_E"DIDISKUALIFIKASI.");
		    RemovePlayerFromVehicle(playerid);
		    pData[playerid][pDriveLicApp] = 0;
		    SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
		}
	}
	if(pData[playerid][pVehSong] == 1)
	{
		pData[playerid][pVehSong] = 0;
		StopAudioStreamForPlayer(playerid);
		Servers(playerid, "Song stop!");
	}
	if(pData[playerid][pSideJob] == 6) //pizza boy
	{
		vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 448)
		{
			DisablePlayerCheckpoint(playerid);
			DisablePlayerRaceCheckpoint(playerid);
			Info(playerid, "Anda Dengan Sengaja Keluar Dari Kendaraan Pizza, Anda Harus "RED_E"MULAI DARI AWAL.");
			//pData[playerid][p] = 0;
			pData[playerid][pSideJob] = 0;
			pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
			SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
		}
	}
	if(pData[playerid][pSideJob] == 1)
	{
		vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 574)
		{
			DisablePlayerCheckpoint(playerid);
			DisablePlayerRaceCheckpoint(playerid);
			Info(playerid, "Anda Dengan Sengaja Keluar Dari Mobil Sweeper, Anda Harus "RED_E"MULAI DARI AWAL.");
			pData[playerid][pSweeper] = 0;
			pData[playerid][pSideJob] = 0;
			pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
			SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
		}
	}
	if(pData[playerid][pSideJob] == 2)
	{
		vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 431)
		{
			DisablePlayerCheckpoint(playerid);
			DisablePlayerRaceCheckpoint(playerid);
			Info(playerid, "Anda Dengan Sengaja Keluar Dari Bus, Anda Harus "RED_E"MULAI DARI AWAL.");
			pData[playerid][pBus] = 0;
			pData[playerid][pSideJob] = 0;
			pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
			SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
		}
	}
	if(pData[playerid][pSideJob] == 5)
	{
		vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 538)
		{
			DisablePlayerCheckpoint(playerid);
			DisablePlayerRaceCheckpoint(playerid);
			Info(playerid, "Anda Dengan Sengaja Keluar Dari kendaraan, Anda Harus "RED_E"MULAI DARI AWAL.");
			pData[playerid][pStreak] = 0;
			pData[playerid][pSideJob] = 0;
			pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
			SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
		}
	}
	if(pData[playerid][pSideJob] == 3)
	{
		vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 530)
		{
			pData[playerid][pSideJob] = 0;
			pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
			SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			DisablePlayerCheckpoint(playerid);
			DisablePlayerRaceCheckpoint(playerid);
			Info(playerid, "Anda Dengan Sengaja Keluar Dari kendaraan, Anda Harus "RED_E"MULAI DARI AWAL.");
		}
	}
	if(pData[playerid][pSideJob] == 4)
	{
		vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 572)
		{
			pData[playerid][pSideJob] = 0;
			pData[playerid][pMower] = 0;
			pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
			SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			DisablePlayerCheckpoint(playerid);
			DisablePlayerRaceCheckpoint(playerid);
			Info(playerid, "Anda Dengan Sengaja Keluar Dari kendaraan, Anda Harus "RED_E"MULAI DARI AWAL.");
		}
	}
	//vpara
	/*if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
    { 
        vpara[playerid]=0; 
        DestroyDynamicObject(para[vehicleid]); 
    }*/
	//drone
	if( vehicleid == Drones[playerid] ) {
	    SendClientMessage( playerid, COLOR_RED, "You can't exit the drone! Use /drone remove or /drone detonate." );
	}
	pData[playerid][pMarkTemp] = 0;
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	Waypoint_Set(playerid, GetLocation(fX, fY, fZ), fX, fY, fZ);
	if(pData[playerid][pAdminDuty])
	{
		//ShowPlayerDialog(playerid, DIALOG_TPADMIN, DIALOG_STYLE_LIST, "Teleport Admins", "Goto Mark\nGoto LS\nGoto LV\nGoto SF\nSAPD\nSAGS\nBANK", "Pilih", "Tidak");
        //ShowPlayerDialog(playerid, DIALOG_TRACKWS, DIALOG_STYLE_TABLIST_HEADERS,"Track Workshop",location,"Track","Cancel");
		new vehicleid = GetPlayerVehicleID(playerid);
        if(vehicleid > 0 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
        {
                SetVehiclePos(vehicleid, fX, fY, fZ+10);
        }
        else
        {
                SetPlayerPosFindZ(playerid, fX, fY, 999.0);
                SetPlayerVirtualWorld(playerid, 0);
                SetPlayerInterior(playerid, 0);
        }
        InfoMsg(playerid, "Kamu Telah Berhasil Teleport Ke Marker Di Peta di peta.");
	}
//	pData[playerid][pMarkTemp] ==
    foreach (new i : Player)
	{
		if(pData[i][pMarkTemp] == pData[playerid][pMarkTemp] && pData[playerid][pMarkTemp] != 0 && pData[i][pMarkTemp] != 0)
		{
			SetPlayerCheckpoint(i, fX, fY, fZ, 3.0);
			InfoMsg(i, "Waypoint Sharing, Lihat pada map.");
		}
    }
    return 1;
}
    /*}
    return 1;
}*/

stock SenjataHilang(playerid)
{
	new cQuery[4028];
	pData[playerid][pPeluru][0] = 0;
	pData[playerid][pPeluru][1] = 0;
	pData[playerid][pDe] = 0;
	pData[playerid][pKatana] = 0;
	pData[playerid][pMolotov] = 0;
	pData[playerid][p9mm] = 0;
	pData[playerid][pSg] = 0;
	pData[playerid][pSpas] = 0;
	pData[playerid][pMp5] = 0;
	pData[playerid][pM4] = 0;
	pData[playerid][pClip] = 0;
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE players SET peluru_0 = 0, peluru_1 = 0 WHERE reg_id = %i", pData[playerid][pPeluru][0], pData[playerid][pPeluru][1], pData[playerid][pID]);
	mysql_tquery(g_SQL, cQuery);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE players SET de = 0 WHERE reg_id = %i", pData[playerid][pDe], pData[playerid][pID]);
	mysql_tquery(g_SQL, cQuery);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE players SET katana = 0 WHERE reg_id = %i", pData[playerid][pKatana], pData[playerid][pID]);
	mysql_tquery(g_SQL, cQuery);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE players SET molotov = 0 WHERE reg_id = %i", pData[playerid][pMolotov], pData[playerid][pID]);
	mysql_tquery(g_SQL, cQuery);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE players SET 9mm = 0 WHERE reg_id = %i", pData[playerid][p9mm], pData[playerid][pID]);
	mysql_tquery(g_SQL, cQuery);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE players SET sg = 0 WHERE reg_id = %i", pData[playerid][pSg], pData[playerid][pID]);
	mysql_tquery(g_SQL, cQuery);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE players SET spas = 0 WHERE reg_id = %i", pData[playerid][pSpas], pData[playerid][pID]);
	mysql_tquery(g_SQL, cQuery);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE players SET mp5 = 0 WHERE reg_id = %i", pData[playerid][pMp5], pData[playerid][pID]);
	mysql_tquery(g_SQL, cQuery);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE players SET m4 = 0 WHERE reg_id = %i", pData[playerid][pM4], pData[playerid][pID]);
	mysql_tquery(g_SQL, cQuery);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE players SET clip = 0 WHERE reg_id = %i", pData[playerid][pClip], pData[playerid][pID]);
	mysql_tquery(g_SQL, cQuery);
	return 1;
}

stock SendDiscordMessage(channel, message[]) {
	new DCC_Channel:ChannelId;
	switch(channel)
	{
		//==[ Log Join & Leave ]
		case 0:
		{
			ChannelId = DCC_FindChannelById("1217110391130165358");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		//==[ Log Command ]
		case 1:
		{
			ChannelId = DCC_FindChannelById("1217110534395269261");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		//==[ Log Chat IC ]
		case 2:
		{
			ChannelId = DCC_FindChannelById("1217110608206364754");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		//==[ Warning & Banned ]
		case 3:
		{
			ChannelId = DCC_FindChannelById("1217110684958064790");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		//==[ Log Death ]
		case 4:
		{
			ChannelId = DCC_FindChannelById("1286284984352768000");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		//==[ Ucp ]
		case 5:
		{
			ChannelId = DCC_FindChannelById("1195951480763596820");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		case 6://Korup
		{
			ChannelId = DCC_FindChannelById("1195984725031010405");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		case 7://Register
		{
			ChannelId = DCC_FindChannelById("1195951480763596820");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		case 8://Bot Admin
		{
			ChannelId = DCC_FindChannelById("1202513472361996298");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		case 9://CMD Admin
		{
			ChannelId = DCC_FindChannelById("1217110249887240293");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		case 10://paylogs
		{
			ChannelId = DCC_FindChannelById("1256349359205781605");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		case 11://CMD
		{
			ChannelId = DCC_FindChannelById("1217110534395269261");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		case 12://Player Check
		{
			ChannelId = DCC_FindChannelById("1217111248156758187");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		case 13://log House
		{
			ChannelId = DCC_FindChannelById("1217111473390878801");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		case 14://PEDAGANGLOGS
		{
			ChannelId = DCC_FindChannelById("1217111553082392686");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		case 15://bISNIS LOGS
		{
			ChannelId = DCC_FindChannelById("1256349359205781605");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		case 16://bank LOGS
		{
			ChannelId = DCC_FindChannelById("1255342971830931466");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		case 17://bank LOGS
		{
			ChannelId = DCC_FindChannelById("1217111688986493130");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
	}
	return 1;
}

function DoGMX()
{
	foreach(new i : Player)
	{
		UpdateWeapons(i);
		UpdatePlayerData(i);
		Servers(i, "Mohon Maaf Server Restart, Data Semua Warga Sudah Di Save Di Database.");
	}
	SendRconCommand("gmx");
	return 1;
}
stock RefreshVModel(playerid)
{
	PlayerTextDrawSetPreviewModel(playerid, VModelTD[playerid], GetVehicleModel(GetPlayerVehicleID(playerid)));
	PlayerTextDrawShow(playerid, VModelTD[playerid]);
    return 1;
}

stock SetPlayerSkinEx(playerid, skinid)
{
	SetPlayerSkin(playerid, skinid);
	//if(pData[playerid][pHBEMode] == 2)
	//{
	//	PlayerTextDrawSetPreviewModel(playerid, PSkinStats[playerid], GetPlayerSkin(playerid));
	//	PlayerTextDrawShow(playerid, PSkinStats[playerid]);
	//}
    return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
    if(pData[forplayerid][pMaskOn]) ShowPlayerNameTagForPlayer(playerid, forplayerid, 0);
    else ShowPlayerNameTagForPlayer(playerid, forplayerid, 1);
    return 1;
}

public OnPlayerSelectionMenuResponse(playerid, extraid, response, listitem, modelid)
{
	switch(extraid)
	{
		case SPAWN_SKIN_MALE:
		{
			if(response)
			{
				//SendClientMessageEx(playerid,COLOR_WHITE,"[i]: Registrasi Berhasil! Terima kasih telah bergabung dengan One Pride ><!");
				pData[playerid][pSkin] = modelid;
				SetPlayerSkinEx(playerid, modelid);
				SetSpawnInfo(playerid, 0, pData[playerid][pSkin], 1743.1216, -1862.2526, 13.5765, 358.9229, 0, 0, 0, 0, 0, 0);
				// SpawnPlayer(playerid);
				SetPlayerPositionEx(playerid, 1743.1216, -1862.2526, 13.5765, 358.9229, 2000);
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				UpdatePlayerData(playerid);
			}
			else
			{
				pData[playerid][pGender] = 0;
				Servers(playerid, "Kamu harus memilih skin!");	
				Kick(playerid);
			}
		}
		case SPAWN_SKIN_FEMALE:
		{
			if(response)
			{
				//SendClientMessageEx(playerid,COLOR_WHITE,"[i]: Registrasi Berhasil! Terima kasih telah bergabung dengan One Pride ><!");
				pData[playerid][pSkin] = modelid;
				SetPlayerSkinEx(playerid, modelid);
				SetSpawnInfo(playerid, 0, pData[playerid][pSkin], 1743.1216, -1862.2526,13.5765, 358.9229, 0, 0, 0, 0, 0, 0);				
				//SpawnPlayer(playerid);
				SetPlayerPositionEx(playerid, 1743.1216, -1862.2526, 13.5765, 358.9229, 2000);
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);

				UpdatePlayerData(playerid);
			}
			else
			{
				pData[playerid][pGender] = 0;
				Servers(playerid, "Kamu harus memilih skin!");	
				Kick(playerid);
			}
		}
		case SHOP_SKIN_MALE:
	    {
	        if(response)
	        {
				new bizid = pData[playerid][pInBiz], price;
				price = bData[bizid][bP][0];
				pData[playerid][pSkin] = modelid;
				SetPlayerSkinEx(playerid, modelid);
				GivePlayerMoneyEx(playerid, -price);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli skin ID %d seharga %s.", ReturnName(playerid), modelid, FormatMoney(price));
				SuccesMsg(playerid, "Anda telah membeli pakaian baru");
				bData[bizid][bProd]--;
				bData[bizid][bMoney] += Server_Percent(price);
				Server_AddPercent(price);
				
				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET prod='%d', money='%d' WHERE ID='%d'", bData[bizid][bProd], bData[bizid][bMoney], bizid);
				mysql_tquery(g_SQL, query);

				Info(playerid, "Anda telah mengganti skin menjadi ID %d", modelid);
			}
			else 
				return Servers(playerid, "Canceled buy skin");	
		}	
		case SHOP_SKIN_FEMALE:
	    {
			if(response)
			{
				new bizid = pData[playerid][pInBiz], price;
				price = bData[bizid][bP][0];
				pData[playerid][pSkin] = modelid;
				SetPlayerSkinEx(playerid, modelid);
				GivePlayerMoneyEx(playerid, -price);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli skin ID %d seharga %s.", ReturnName(playerid), modelid, FormatMoney(price));
				SuccesMsg(playerid, "Anda telah membeli pakaian baru");
				bData[bizid][bProd]--;
				bData[bizid][bMoney] += Server_Percent(price);
				Server_AddPercent(price);
				
				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET prod='%d', money='%d' WHERE ID='%d'", bData[bizid][bProd], bData[bizid][bMoney], bizid);
				mysql_tquery(g_SQL, query);

				Info(playerid, "Anda telah mengganti skin menjadi ID %d", modelid);
			}
			else 
				return Servers(playerid, "Canceled buy skin");	
		}
		case VIP_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pSkin] = modelid;
				SetPlayerSkinEx(playerid, modelid);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah mengganti skin ID %d.", ReturnName(playerid), modelid);
				Info(playerid, "Anda telah mengganti skin menjadi ID %d", modelid);
				
			}
			else 
				return Servers(playerid, "Canceled buy skin");
		}
		case VIP_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pSkin] = modelid;
				SetPlayerSkinEx(playerid, modelid);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah mengganti skin ID %d.", ReturnName(playerid), modelid);
				Info(playerid, "Anda telah mengganti skin menjadi ID %d", modelid);
				
			}
			else 
				return Servers(playerid, "Canceled buy skin");
		}
		case SAPD_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkinEx(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
				
			}	
		}
		case SAPD_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkinEx(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
				
			}	
		}
		case SAPD_SKIN_WAR:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkinEx(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
				
			}	
		}
		case SAGS_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkinEx(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
				
			}	
		}
		case SAGS_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkinEx(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
				
			}	
		}
		case SAMD_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkinEx(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
				
			}	
		}
		case SAMD_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkinEx(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
				
			}	
		}
		case SANA_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkinEx(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
				
			}	
		}
		case SANA_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkinEx(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
				
			}	
		}
		case GOCAR_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkinEx(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
				
			}	
		}
		case GOCAR_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkinEx(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
				
			}	
		}
		case TOYS_MODEL:
		{
			if(response)
			{
				new bizid = pData[playerid][pInBiz], price;
				price = bData[bizid][bP][1];
				
				GivePlayerMoneyEx(playerid, -price);
				if(pData[playerid][PurchasedToy] == false) MySQL_CreatePlayerToy(playerid);
				pToys[playerid][pData[playerid][toySelected]][toy_model] = modelid;
				pToys[playerid][pData[playerid][toySelected]][toy_status] = 1;
				new finstring[750];
				strcat(finstring, ""dot"Spine\n"dot"Head\n"dot"Left upper arm\n"dot"Right upper arm\n"dot"Left hand\n"dot"Right hand\n"dot"Left thigh\n"dot"Right tigh\n"dot"Left foot\n"dot"Right foot");
				strcat(finstring, "\n"dot"Right calf\n"dot"Left calf\n"dot"Left forearm\n"dot"Right forearm\n"dot"Left clavicle\n"dot"Right clavicle\n"dot"Neck\n"dot"Jaw");
				ShowPlayerDialog(playerid, DIALOG_TOYPOSISIBUY, DIALOG_STYLE_LIST, ""WHITE_E"Select Bone", finstring, "Select", "Cancel");
				
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli object ID %d seharga %s.", ReturnName(playerid), modelid, FormatMoney(price));
				bData[bizid][bProd]--;
				bData[bizid][bMoney] += Server_Percent(price);
				Server_AddPercent(price);

				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET prod='%d', money='%d' WHERE ID='%d'", bData[bizid][bProd], bData[bizid][bMoney], bizid);
				mysql_tquery(g_SQL, query);
			}
			else 
				return Servers(playerid, "Canceled buy toys");
		}
		case VIPTOYS_MODEL:
		{
			if(response)
			{
				if(pData[playerid][PurchasedToy] == false) MySQL_CreatePlayerToy(playerid);
				pToys[playerid][pData[playerid][toySelected]][toy_model] = modelid;
				pToys[playerid][pData[playerid][toySelected]][toy_status] = 1;
				new finstring[750];
				strcat(finstring, ""dot"Spine\n"dot"Head\n"dot"Left upper arm\n"dot"Right upper arm\n"dot"Left hand\n"dot"Right hand\n"dot"Left thigh\n"dot"Right tigh\n"dot"Left foot\n"dot"Right foot");
				strcat(finstring, "\n"dot"Right calf\n"dot"Left calf\n"dot"Left forearm\n"dot"Right forearm\n"dot"Left clavicle\n"dot"Right clavicle\n"dot"Neck\n"dot"Jaw");
				ShowPlayerDialog(playerid, DIALOG_TOYPOSISIBUY, DIALOG_STYLE_LIST, ""WHITE_E"Select Bone", finstring, "Select", "Cancel");
				
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah mengambil object ID %d dilocker.", ReturnName(playerid), modelid);
			}
			else
				return Servers(playerid, "Canceled toys");
		}
	}
	return 1;
}	

public OnPlayerEditVehicleObject(playerid,vehicleid,response,Float:x,Float:y,Float:z,Float:rx,Float:ry,Float:rz)
{
	if(response)
	{
	    new idxs = pData[playerid][pVehicle];
	    pvData[idxs][vToyPosX][pData[playerid][pListitem]] = x;
		pvData[idxs][vToyPosY][pData[playerid][pListitem]] = y;
		pvData[idxs][vToyPosZ][pData[playerid][pListitem]] = z;
		pvData[idxs][vToyRotX][pData[playerid][pListitem]] = rx;
		pvData[idxs][vToyRotY][pData[playerid][pListitem]] = ry;
		pvData[idxs][vToyRotZ][pData[playerid][pListitem]] = rz;
	}
	return 1;
}
//enterdoor
public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
    if(EnterDoor(playerid))
    {
        GameTextForPlayer(playerid, "~w~PRES ~r~ENTER ~w~OR ~r~F~n~~w~TO ENTER/EXIT", 4000, 4);
        return 1;
    }

    if(EnterHouse(playerid))
    {
        GameTextForPlayer(playerid, "~w~PRES ~r~ENTER ~w~OR ~r~F~n~~w~TO ENTER/EXIT", 4000, 4);
        return 1;
    }

    if(EnterBisnis(playerid))
    {
        GameTextForPlayer(playerid, "~w~PRES ~r~ENTER ~w~OR ~r~F~n~~w~TO ENTER/EXIT", 4000, 4);
        return 1;
    }

    for(new i = 0; i < sizeof(MoneyInfo); i++) //MoneyBags
    {
        if(MoneyInfo[i][mCreated] == 1) 
        {
            new Float:X, Float:Y, Float:Z;
            X = MoneyInfo[i][mbX];
            Y = MoneyInfo[i][mbY];
            Z = MoneyInfo[i][mbZ];
            new amount = MoneyInfo[i][mAmount];
            new pickupidd = MoneyInfo[i][mPickup];

            if(pickupidd == pickupidd) 
            {
                if(MoneyInfo[i][mMoneybag] == 0) return 1;
                if(IsPlayerInRangeOfPoint(playerid, 5.0, X, Y, Z))
                {
                    new string[128];
                    new sendername[MAX_PLAYER_NAME];
                    new Float:plax, Float:play, Float:plaz;
                    new location[MAX_ZONE_NAME];
					
                    GivePlayerMoney(playerid, amount);
					pData[playerid][pMoney] += amount;
                    format(string, sizeof(string), "~w~You found the money bag worth~n~~g~$%d!", amount);
                    GameTextForPlayer(playerid, string, 5000, 3);
                    GetPlayerPos(playerid, plax, play, plaz);
                    PlayerPlaySound(playerid, 1056, plax, play, plaz);
                    DestroyDynamicPickup(MoneyInfo[i][mPickup]);
                    MoneyInfo[i][mCreated] = 0;
                    
                    GetPlayer2DZone(playerid, location, MAX_ZONE_NAME);
                    GetPlayerName(playerid, sendername, sizeof(sendername));
                    format(string, sizeof(string), "[INFO]: %s has picked up a money bag in %s worth {ffff00}$%d.", sendername, location, amount);
                    SendClientMessageToAll(COLOR_LIGHTRED, string);                    
                    return 1;
                }
            }
        }
    }

    return 1;
}
stock DisplayDokumen(playerid)
{
    new ktpstatus[36];
	if(pData[playerid][pIDCard] == 1)
	{
		format(ktpstatus, 36, ""LG_E"Ada");
	}
	else
	{
		format(ktpstatus, 36, ""RED_E"Tidak");
	}

	new simstatus[36];
	if(pData[playerid][pDriveLic] == 1)
	{
		format(simstatus, 36, ""LG_E"Ada");
	}
	else
	{
		format(simstatus, 36, ""RED_E"Tidak");
	}
	
	new weaponstatus[36];
	if(pData[playerid][pWeaponLic] == 1)
	{
		format(weaponstatus, 36, ""LG_E"Ada");
	}
	else
	{
		format(weaponstatus, 36, ""RED_E"Tidak");
	}
	new string[2048];
	format(string, sizeof(string),"Kartu Tanda Penduduk\t[%s]\nSurat Izin Mengemudi\t[%s]\nLisensi Senjata\t[%s]",
    ktpstatus,
	simstatus,
	weaponstatus);
	ShowPlayerDialog(playerid, DIALOG_DOKUMEN, DIALOG_STYLE_LIST, "One Pride - Dokumen", string, "Tutup","");
}
function UseClip(playerid, gunid, ammo)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pArmsDealer])) return 0;
	if(gunid == 0 || ammo == 0) return 0;
	if(pData[playerid][pActivityTime] >= 25)
	{
		GivePlayerWeaponEx(playerid, gunid, ammo);
		
        ClearAnimations(playerid);
		//SuccesMsg(playerid, "Reload sukses.");
		//ShowItemBox(playerid, "Clip", "Terpakai_1x", 19995, 2);
		TogglePlayerControllable(playerid, true);
		//InfoTD_MSG(playerid, 8000, "Weapon Reload!");
		KillTimer(pData[playerid][pArmsDealer]);
		pData[playerid][pActivityTime] = 0;
		HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		pData[playerid][pEnergy] -= 3;
		return 1;
	}
	else if(pData[playerid][pActivityTime] < 25)
	{
		pData[playerid][pActivityTime] += 50;
		SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		ApplyAnimation(playerid,"COLT45","colt45_reload",4.0, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}
public OnModelSelectionResponse(playerid, extraid, index, modelid, response)
{
	if ((response) && (extraid == MODEL_SELECTION_MODSHOP))
	{
	    if(GetPlayerMoney(playerid) < 800)
	        return ErrorMsg(playerid, "You need $800 to purchase attachment's");
	        
	    new Float:pX, Float:pY, Float:pZ, Float:pA;

		new x = pData[playerid][pVehicle];

		GetVehiclePos(pvData[x][cVeh], pX, pY, pZ);
		GetVehicleZAngle(pvData[x][cVeh], pA);
		pvData[x][vToyID][pData[playerid][pListitem]] = modelid;

		pvData[x][vToyPosX][pData[playerid][pListitem]] = 0.00000;
		pvData[x][vToyPosY][pData[playerid][pListitem]] = 0.00000;
		pvData[x][vToyPosZ][pData[playerid][pListitem]] = 0.00000;
		pvData[x][vToyRotX][pData[playerid][pListitem]] = 0.00000;
		pvData[x][vToyRotY][pData[playerid][pListitem]] = 0.00000;
		pvData[x][vToyRotZ][pData[playerid][pListitem]] = 0.00000;
		pvData[x][vToy][pData[playerid][pListitem]] = CreateDynamicObject(modelid,pX, pY, pZ,0,0,pA);
		AttachDynamicObjectToVehicle(pvData[x][vToy][pData[playerid][pListitem]], pvData[x][cVeh], 0, 0, 0, 0, 0, 0);

		Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
		GivePlayerMoneyEx(playerid, -200);
		ShowItemBox(playerid, "Uang", "Removed_$200", 1212, 4);
		Servers(playerid, "You have successfully purchased vehicle attachment for slot %d! (model: %d)", pData[playerid][pListitem] + 1, modelid);
		SuccesMsg(playerid, "Use /vattach to manage vehicle attachment's!");
	}
	return 1;
}
forward DestroyWater(objectid);
public DestroyWater(objectid)
{
	if (IsValidDynamicObject(objectid))
	    DestroyDynamicObject(objectid);

	return 0;
}
forward RandomFire();
public RandomFire()
{
	for (new i = 0; i < sizeof(g_aFireObjects); i ++)
	{
	    g_aFireExtinguished[i] = 0;

	    if (IsValidDynamicObject(g_aFireObjects[i]))
	        DestroyDynamicObject(g_aFireObjects[i]);
	}
	switch (random(5))
	{
	    case 0:
	    {
			g_aFireObjects[0] = CreateDynamicObject(18691, 1930.4942, -1784.1799, 10.9368, 0.0, 0.0, 0.0);
			g_aFireObjects[1] = CreateDynamicObject(18691, 1930.5037, -1782.1473, 10.9368, 0.0, 0.0, 0.0);
			g_aFireObjects[2] = CreateDynamicObject(18691, 1930.5136, -1779.6364, 10.9368, 0.0, 0.0, 0.0);
			g_aFireObjects[3] = CreateDynamicObject(18691, 1930.5238, -1777.1058, 10.9368, 0.0, 0.0, 0.0);
			g_aFireObjects[4] = CreateDynamicObject(18691, 1930.5346, -1774.5141, 10.9368, 0.0, 0.0, 0.0);
			g_aFireObjects[5] = CreateDynamicObject(18691, 1930.5428, -1772.4306, 10.9368, 0.0, 0.0, 0.0);
			g_aFireObjects[6] = CreateDynamicObject(18691, 1930.5507, -1770.4219, 10.9368, 0.0, 0.0, 0.0);
			g_aFireObjects[7] = CreateDynamicObject(18691, 1930.5588, -1768.3559, 10.9368, 0.0, 0.0, 0.0);
			g_aFireObjects[8] = CreateDynamicObject(18691, 1929.1459, -1767.9173, 14.3093, 0.0, 0.0, 0.0);
			g_aFireObjects[9] = CreateDynamicObject(18691, 1928.8776, -1769.5853, 14.3093, 0.0, 0.0, 0.0);
			g_aFireObjects[10] = CreateDynamicObject(18691, 1928.8422, -1772.0158, 14.3093, 0.0, 0.0, 0.0);
			g_aFireObjects[11] = CreateDynamicObject(18691, 1928.8189, -1773.6047, 14.3093, 0.0, 0.0, 0.0);
			g_aFireObjects[12] = CreateDynamicObject(18691, 1928.8001, -1774.8883, 14.3093, 0.0, 0.0, 0.0);
			g_aFireObjects[13] = CreateDynamicObject(18691, 1928.7772, -1776.4462, 14.3093, 0.0, 0.0, 0.0);
			g_aFireObjects[14] = CreateDynamicObject(18691, 1928.7534, -1778.0637, 14.3093, 0.0, 0.0, 0.0);
			g_aFireObjects[15] = CreateDynamicObject(18691, 1928.7347, -1779.3225, 14.3093, 0.0, 0.0, 0.0);
			g_aFireObjects[16] = CreateDynamicObject(18691, 1928.7145, -1780.7152, 14.3093, 0.0, 0.0, 0.0);
			g_aFireObjects[17] = CreateDynamicObject(18691, 1928.6938, -1782.1208, 14.3093, 0.0, 0.0, 0.0);
			g_aFireObjects[18] = CreateDynamicObject(18691, 1928.6655, -1784.0491, 14.3093, 0.0, 0.0, 0.0);
			g_aFireObjects[19] = CreateDynamicObject(18691, 1935.3200, -1783.8045, 10.7728, 0.0, 0.0, 0.0);
			g_aFireObjects[20] = CreateDynamicObject(18691, 1935.2098, -1781.6428, 10.7728, 0.0, 0.0, 0.0);
			g_aFireObjects[21] = CreateDynamicObject(18691, 1935.0748, -1778.9934, 10.7728, 0.0, 0.0, 0.0);
			g_aFireObjects[22] = CreateDynamicObject(18691, 1934.9506, -1776.5572, 10.7728, 0.0, 0.0, 0.0);
			g_aFireObjects[23] = CreateDynamicObject(18691, 1934.8343, -1774.2791, 10.7728, 0.0, 0.0, 0.0);
			g_aFireObjects[24] = CreateDynamicObject(18691, 1934.7189, -1772.0156, 10.7728, 0.0, 0.0, 0.0);
			g_aFireObjects[25] = CreateDynamicObject(18691, 1934.6302, -1770.2773, 10.7728, 0.0, 0.0, 0.0);
			g_aFireObjects[26] = CreateDynamicObject(18691, 1934.5228, -1768.1666, 10.7728, 0.0, 0.0, 0.0);
		}
		case 1:
		{
			g_aFireObjects[0] = CreateDynamicObject(18691, 1238.8894, -1563.0980, 10.9999, 0.0, 0.0, 0.0);
			g_aFireObjects[1] = CreateDynamicObject(18691, 1241.6730, -1562.6481, 11.0068, 0.0, 0.0, 0.0);
			g_aFireObjects[2] = CreateDynamicObject(18691, 1243.2508, -1561.0845, 10.9444, 0.0, 0.0, 0.0);
			g_aFireObjects[3] = CreateDynamicObject(18691, 1245.5793, -1560.6265, 10.9450, 0.0, 0.0, 0.0);
			g_aFireObjects[4] = CreateDynamicObject(18691, 1247.4980, -1560.4841, 10.9455, 0.0, 0.0, 0.0);
			g_aFireObjects[5] = CreateDynamicObject(18691, 1249.9790, -1560.3701, 10.9539, 0.0, 0.0, 0.0);
			g_aFireObjects[6] = CreateDynamicObject(18691, 1249.5944, -1562.7432, 11.0053, 0.0, 0.0, 0.0);
			g_aFireObjects[7] = CreateDynamicObject(18691, 1247.4562, -1562.7996, 11.0045, 0.0, 0.0, 0.0);
			g_aFireObjects[8] = CreateDynamicObject(18691, 1245.7386, -1563.1572, 10.9990, 0.0, 0.0, 0.0);
			g_aFireObjects[9] = CreateDynamicObject(18691, 1243.7620, -1563.7636, 10.9896, 0.0, 0.0, 0.0);
			g_aFireObjects[10] = CreateDynamicObject(18691, 1242.2908, -1563.0959, 10.9999, 0.0, 0.0, 0.0);
			g_aFireObjects[11] = CreateDynamicObject(18691, 1242.3502, -1564.7818, 10.9740, 0.0, 0.0, 0.0);
			g_aFireObjects[12] = CreateDynamicObject(18691, 1244.8713, -1564.6507, 10.9760, 0.0, 0.0, 0.0);
			g_aFireObjects[13] = CreateDynamicObject(18691, 1246.8665, -1564.5694, 10.9772, 0.0, 0.0, 0.0);
			g_aFireObjects[14] = CreateDynamicObject(18691, 1249.1672, -1563.8638, 10.9881, 0.0, 0.0, 0.0);
			g_aFireObjects[15] = CreateDynamicObject(18691, 1250.8759, -1563.9959, 10.9861, 0.0, 0.0, 0.0);
			g_aFireObjects[16] = CreateDynamicObject(18691, 1252.2437, -1562.3538, 11.0113, 0.0, 0.0, 0.0);
			g_aFireObjects[17] = CreateDynamicObject(18691, 1252.4475, -1561.7529, 13.6369, 0.0, 0.0, 0.0);
			g_aFireObjects[18] = CreateDynamicObject(18691, 1250.9642, -1561.7822, 13.6519, 0.0, 0.0, 0.0);
			g_aFireObjects[19] = CreateDynamicObject(18691, 1248.5258, -1561.3541, 13.8278, 0.0, 0.0, 0.0);
			g_aFireObjects[20] = CreateDynamicObject(18691, 1245.9611, -1561.1191, 13.5507, 0.0, 0.0, 0.0);
			g_aFireObjects[21] = CreateDynamicObject(18691, 1242.7899, -1561.6608, 13.7519, 0.0, 0.0, 0.0);
			g_aFireObjects[22] = CreateDynamicObject(18691, 1250.3793, -1561.5445, 10.9462, 0.0, 0.0, 0.0);
			g_aFireObjects[23] = CreateDynamicObject(18691, 1252.8653, -1561.6358, 10.9468, 0.0, 0.0, 0.0);
			g_aFireObjects[24] = CreateDynamicObject(18691, 1252.9653, -1563.4675, 10.9942, 0.0, 0.0, 0.0);
			g_aFireObjects[25] = CreateDynamicObject(18691, 1252.5823, -1563.9747, 10.9864, 0.0, 0.0, 0.0);
		}
		case 2:
		{
		    g_aFireObjects[0] = CreateDynamicObject(18691, 1786.4844, -1164.2786, 21.2181, 0.0, 0.0, 0.0);
			g_aFireObjects[1] = CreateDynamicObject(18691, 1787.8876, -1164.3374, 21.2181, 0.0, 0.0, 0.0);
			g_aFireObjects[2] = CreateDynamicObject(18691, 1790.0416, -1164.8181, 21.2181, 0.0, 0.0, 0.0);
			g_aFireObjects[3] = CreateDynamicObject(18691, 1791.7430, -1165.1977, 21.2181, 0.0, 0.0, 0.0);
			g_aFireObjects[4] = CreateDynamicObject(18691, 1793.3637, -1165.5594, 21.2181, 0.0, 0.0, 0.0);
			g_aFireObjects[5] = CreateDynamicObject(18691, 1794.8229, -1165.8847, 21.2181, 0.0, 0.0, 0.0);
			g_aFireObjects[6] = CreateDynamicObject(18691, 1796.5830, -1166.2770, 21.2181, 0.0, 0.0, 0.0);
			g_aFireObjects[7] = CreateDynamicObject(18691, 1798.3182, -1166.6638, 21.2181, 0.0, 0.0, 0.0);
			g_aFireObjects[8] = CreateDynamicObject(18691, 1798.2283, -1166.9202, 22.1465, 0.0, 0.0, 0.0);
			g_aFireObjects[9] = CreateDynamicObject(18691, 1797.1246, -1166.2222, 22.5881, 0.0, 0.0, 0.0);
			g_aFireObjects[10] = CreateDynamicObject(18691, 1796.1480, -1165.5697, 22.5401, 0.0, 0.0, 0.0);
			g_aFireObjects[11] = CreateDynamicObject(18691, 1795.4377, -1165.1295, 22.1495, 0.0, 0.0, 0.0);
			g_aFireObjects[12] = CreateDynamicObject(18691, 1794.7139, -1164.6824, 21.4488, 0.0, 0.0, 0.0);
			g_aFireObjects[13] = CreateDynamicObject(18691, 1789.6914, -1164.0892, 22.3047, 0.0, 0.0, 0.0);
			g_aFireObjects[14] = CreateDynamicObject(18691, 1788.5687, -1163.1995, 22.3698, 0.0, 0.0, 0.0);
			g_aFireObjects[15] = CreateDynamicObject(18691, 1788.0295, -1162.8452, 21.9937, 0.0, 0.0, 0.0);
			g_aFireObjects[16] = CreateDynamicObject(18691, 1786.2319, -1163.1064, 21.8608, 0.0, 0.0, 0.0);
			g_aFireObjects[17] = CreateDynamicObject(18691, 1785.3194, -1163.1263, 21.9294, 0.0, 0.0, 0.0);
			g_aFireObjects[18] = CreateDynamicObject(18691, 1791.5643, -1163.1118, 21.3996, 0.0, 0.0, 0.0);
			g_aFireObjects[19] = CreateDynamicObject(18691, 1791.8800, -1164.3983, 22.2759, 0.0, 0.0, 0.0);
			g_aFireObjects[20] = CreateDynamicObject(18691, 1791.8519, -1165.1618, 22.5094, 0.0, 0.0, 0.0);
			g_aFireObjects[21] = CreateDynamicObject(18691, 1788.8287, -1163.4260, 22.0600, 0.0, 0.0, 0.0);
			g_aFireObjects[22] = CreateDynamicObject(18691, 1790.2512, -1164.0129, 21.2942, 0.0, 0.0, 0.0);
		}
		case 3:
		{
		    g_aFireObjects[0] = CreateDynamicObject(18691, 1315.0238, -1368.2282, 10.9438, 0.0, 0.0, 0.0);
			g_aFireObjects[1] = CreateDynamicObject(18691, 1314.0100, -1368.2265, 10.9438, 0.0, 0.0, 0.0);
			g_aFireObjects[2] = CreateDynamicObject(18691, 1312.6562, -1368.2235, 10.9399, 0.0, 0.0, 0.0);
			g_aFireObjects[3] = CreateDynamicObject(18691, 1311.8308, -1367.5294, 10.9296, 0.0, 0.0, 0.0);
			g_aFireObjects[4] = CreateDynamicObject(18691, 1310.9281, -1367.4926, 10.9273, 0.0, 0.0, 0.0);
			g_aFireObjects[5] = CreateDynamicObject(18691, 1309.7708, -1367.4902, 10.9252, 0.0, 0.0, 0.0);
			g_aFireObjects[6] = CreateDynamicObject(18691, 1308.6425, -1367.4877, 10.9232, 0.0, 0.0, 0.0);
			g_aFireObjects[7] = CreateDynamicObject(18691, 1307.3302, -1368.0213, 10.9332, 0.0, 0.0, 0.0);
			g_aFireObjects[8] = CreateDynamicObject(18691, 1306.0062, -1368.3232, 10.9355, 0.0, 0.0, 0.0);
			g_aFireObjects[9] = CreateDynamicObject(18691, 1304.3460, -1368.3197, 10.9354, 0.0, 0.0, 0.0);
			g_aFireObjects[10] = CreateDynamicObject(18691, 1304.4842, -1369.0036, 10.9451, 0.0, 0.0, 0.0);
			g_aFireObjects[11] = CreateDynamicObject(18691, 1305.8629, -1369.4384, 10.9513, 0.0, 0.0, 0.0);
			g_aFireObjects[12] = CreateDynamicObject(18691, 1307.2315, -1369.3804, 10.9512, 0.0, 0.0, 0.0);
			g_aFireObjects[13] = CreateDynamicObject(18691, 1309.0936, -1369.7593, 10.9550, 0.0, 0.0, 0.0);
			g_aFireObjects[14] = CreateDynamicObject(18691, 1310.8515, -1369.5230, 10.9544, 0.0, 0.0, 0.0);
			g_aFireObjects[15] = CreateDynamicObject(18691, 1312.0820, -1369.2214, 10.9522, 0.0, 0.0, 0.0);
			g_aFireObjects[16] = CreateDynamicObject(18691, 1309.4581, -1367.9462, 13.2241, 0.0, 0.0, 0.0);
			g_aFireObjects[17] = CreateDynamicObject(18691, 1307.8933, -1367.5498, 13.5101, 0.0, 0.0, 0.0);
			g_aFireObjects[18] = CreateDynamicObject(18691, 1307.3311, -1369.9162, 13.0364, 0.0, 0.0, 0.0);
			g_aFireObjects[19] = CreateDynamicObject(18691, 1306.5539, -1370.5288, 12.7001, 0.0, 0.0, 0.0);
			g_aFireObjects[20] = CreateDynamicObject(18691, 1310.9852, -1369.3835, 12.2585, 0.0, 0.0, 0.0);
			g_aFireObjects[21] = CreateDynamicObject(18691, 1310.3361, -1370.6992, 12.9585, 0.0, 0.0, 0.0);
			g_aFireObjects[22] = CreateDynamicObject(18691, 1313.2864, -1370.2733, 10.9708, 0.0, 0.0, 0.0);
			g_aFireObjects[23] = CreateDynamicObject(18691, 1313.3056, -1371.2634, 10.9838, 0.0, 0.0, 0.0);
			g_aFireObjects[24] = CreateDynamicObject(18691, 1311.6168, -1370.8870, 10.9735, 0.0, 0.0, 0.0);
			g_aFireObjects[25] = CreateDynamicObject(18691, 1308.9244, -1371.1181, 10.9726, 0.0, 0.0, 0.0);
			g_aFireObjects[26] = CreateDynamicObject(18691, 1306.5335, -1370.7678, 10.9712, 0.0, 0.0, 0.0);
		}
		case 4:
		{
		    g_aFireObjects[0] = CreateDynamicObject(18691, 997.7821, -910.8650, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[1] = CreateDynamicObject(18691, 998.0914, -911.5863, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[2] = CreateDynamicObject(18691, 998.2116, -913.0366, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[3] = CreateDynamicObject(18691, 998.3492, -914.6963, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[4] = CreateDynamicObject(18691, 998.4992, -916.5079, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[5] = CreateDynamicObject(18691, 998.6508, -918.3324, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[6] = CreateDynamicObject(18691, 998.7961, -920.0861, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[7] = CreateDynamicObject(18691, 998.9600, -922.0629, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[8] = CreateDynamicObject(18691, 999.1196, -923.9867, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[9] = CreateDynamicObject(18691, 999.2616, -925.7003, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[10] = CreateDynamicObject(18691, 999.4187, -927.5945, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[11] = CreateDynamicObject(18691, 999.5601, -929.3013, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[12] = CreateDynamicObject(18691, 1000.5933, -931.6047, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[13] = CreateDynamicObject(18691, 1002.6428, -931.3463, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[14] = CreateDynamicObject(18691, 1004.6893, -931.3514, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[15] = CreateDynamicObject(18691, 1007.2104, -931.1424, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[16] = CreateDynamicObject(18691, 1009.8325, -930.9251, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[17] = CreateDynamicObject(18691, 1012.1341, -930.7343, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[18] = CreateDynamicObject(18691, 1014.4911, -930.5388, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[19] = CreateDynamicObject(18691, 1014.4734, -932.3157, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[20] = CreateDynamicObject(18691, 1013.0949, -932.3657, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[21] = CreateDynamicObject(18691, 1011.4746, -932.4245, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[22] = CreateDynamicObject(18691, 1009.7496, -932.4875, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[23] = CreateDynamicObject(18691, 1008.1029, -932.5473, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[24] = CreateDynamicObject(18691, 1006.0109, -932.6234, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[25] = CreateDynamicObject(18691, 1003.9039, -932.7000, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[26] = CreateDynamicObject(18691, 1002.0654, -932.7668, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[27] = CreateDynamicObject(18691, 1002.6585, -933.5130, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[28] = CreateDynamicObject(18691, 1004.5731, -933.4433, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[29] = CreateDynamicObject(18691, 1006.4688, -933.3743, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[30] = CreateDynamicObject(18691, 1008.4611, -933.3016, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[31] = CreateDynamicObject(18691, 1010.4176, -933.2304, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[32] = CreateDynamicObject(18691, 1012.0813, -933.1698, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[33] = CreateDynamicObject(18691, 1013.1374, -933.1314, 39.5696, 0.0, 0.0, 0.0);
			g_aFireObjects[34] = CreateDynamicObject(18691, 1015.3114, -933.0523, 39.5696, 0.0, 0.0, 0.0);
		}
	}
	new
	    Float:fX,
	    Float:fY,
	    Float:fZ;

	GetDynamicObjectPos(g_aFireObjects[0], fX, fY, fZ);

	foreach (new i : Player)
	{
	    if(pData[i][pFaction] == 3)
	    {
			Waypoint_Set(i, "Fire Scene", fX, fY, fZ);
	    }
	}
	//CreateExplosion(fX, fY, fZ, 12, 5.0);
	SendFactionMessage(3, COLOR_RADIO, "RADIO: A fire has been spotted at %s (marked on map).", GetLocation(fX, fY, fZ));
	//SendFactionMessage(3, COLOR_RADIO, "** [SAMD Radio] %s(%d) %s: %s", GetFactionRank(playerid),  pData[playerid][pFactionRank], pData[playerid][pName], text);
	return 1;
}
stock GetDistance(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2)
{
	return floatround(floatsqroot(((x1 - x2) * (x1 - x2)) + ((y1 - y2) * (y1 - y2)) + ((z1 - z2) * (z1 - z2))));
}
stock DistanceCameraTargetToLocation(Float:fCameraX, Float:fCameraY, Float:fCameraZ, Float:fObjectX, Float:fObjectY, Float:fObjectZ, Float:fVectorX, Float:fVectorY, Float:fVectorZ)
{
	new
		Float:fX,
		Float:fY,
		Float:fZ,
		Float:fDistance;

	fDistance = GetDistance(fCameraX, fCameraY, fCameraZ, fObjectX, fObjectY, fObjectZ);

	fX = fVectorX * fDistance + fCameraX;
	fY = fVectorY * fDistance + fCameraY;
	fZ = fVectorZ * fDistance + fCameraZ;

	return floatround(floatsqroot(fX - fObjectX) * (fX - fObjectX) + (fY - fObjectY) * (fY - fObjectY) + (fZ - fObjectZ) * (fZ - fObjectZ));
}


CMD:setskill(playerid, params[])
{
	new choice[128], String[50], giveplayerid, amount;
	if(sscanf(params, "s[128]dd", choice, giveplayerid, amount))
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "USE: /setskill [trucker, mechanic, smuggler] [playerid] [amount]");
		return 1;
	}
	if(strcmp(choice, "mechanic", true) == 0)
	{
		pData[giveplayerid][pMechSkill] = amount;
		format(String, sizeof(String), "SKILLINFO: You've set %s mechanic Skill to Level %d", pData[giveplayerid][pName], amount);

		SendClientMessage(playerid, COLOR_WHITE, String);
	}
	else if(strcmp(choice, "trucker", true) == 0)
	{
		pData[giveplayerid][pTruckSkill] = amount;
		format(String, sizeof(String), "SKILLINFO: You've set %s trucker Skill to Level %d", pData[giveplayerid][pName], amount);

		SendClientMessage(playerid, COLOR_WHITE, String);
	}
	else if(strcmp(choice, "smuggler", true) == 0)
	{
		pData[giveplayerid][pSmuggSkill] = amount;
		format(String, sizeof(String), "SKILLINFO: You've set %s smuggler Skill to Level %d", pData[giveplayerid][pName], amount);

		SendClientMessage(playerid, COLOR_WHITE, String);
	}
	return 1;
}
ptask AfkCheck[1000](playerid)  {
	new str[300];
    if(p_tick[playerid] > 0) {
        p_tick[playerid] = 0, p_afktime[playerid] = 0;
        return 1;
    }
    if(p_tick[playerid] == 0) {
        p_afktime[playerid]++;
    }
    /*if(p_afktime[playerid] > 0) {
        format(str, sizeof str,"[ATIP] %d Second(s)",p_afktime[playerid]);
        SetPlayerChatBubble(playerid, str, COLOR_YELLOW, 10.0, 1000);
    }*/
    new afk_minutes = ConvertUnixTime(p_afktime[playerid], CONVERT_TIME_TO_MINUTES);
	new afk_seconds = ConvertUnixTime(p_afktime[playerid]);

	if(afk_minutes > 0)
	{
		format(str, sizeof str, "[Melamun] %d:%02d Menit(s).", afk_minutes, afk_seconds);
	}
	else format(str, sizeof str, "[Melamun] %d Detik(s).", afk_seconds);
	SetPlayerChatBubble(playerid, str, COLOR_GREEN, 10.0, 1000);
    return 1;
}
stock ConvertUnixTime(unix_time, type = CONVERT_TIME_TO_SECONDS)
{
	switch(type)
	{
		case CONVERT_TIME_TO_SECONDS:
		{
			unix_time %= 60;
		}
		case CONVERT_TIME_TO_MINUTES:
		{
			unix_time = (unix_time / 60) % 60;
		}
		case CONVERT_TIME_TO_HOURS:
		{
			unix_time = (unix_time / 3600) % 24;
		}
		case CONVERT_TIME_TO_DAYS:
		{
			unix_time = (unix_time / 86400) % 30;
		}
		case CONVERT_TIME_TO_MONTHS:
		{
			unix_time = (unix_time / 2629743) % 12;
		}
		case CONVERT_TIME_TO_YEARS:
		{
			unix_time = (unix_time / 31556926) + 1970;
		}
		default:
			unix_time %= 60;
	}
	return unix_time;
}




//Paytax
GetBisnisPaytax(playerid)
{
	new tmpcount;
	foreach(new id : Bisnis)
	{
		if(!strcmp(pData[playerid][pName], bData[id][bOwner], true))
		{
	     	tmpcount++;
		}
	}
	return tmpcount;
}

ReturnBisnisPaytaxID(playerid, slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_BISNIS) return -1;
	foreach(new id : Bisnis)
	{
		if(!strcmp(pData[playerid][pName], bData[id][bOwner], true))
		{
		    tmpcount++;
		    if(tmpcount == slot)
		    {
		    	return id;
		  	}
		}
	}
	return -1;
}

GetHousesPaytax(playerid)
{
	new tmpcount;
	foreach(new hid : Houses)
	{
	    if(!strcmp(hData[hid][hOwner], pData[playerid][pName], true))
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

ReturnHousesPaytaxID(playerid, slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_HOUSES) return -1;
	foreach(new hid : Houses)
	{
		if(!strcmp(pData[playerid][pName], hData[hid][hOwner], true))
		{
		    tmpcount++;
		    if(tmpcount == slot)
		    {
		    	return hid;
		  	}
		}
	}
	return -1;
}

GetDealerPaytax(playerid)
{
	new tmpcount;
	foreach(new drid : Dealer)
	{
	    if(!strcmp(DealerData[drid][dealerOwner], pData[playerid][pName], true))
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

ReturnDealerPaytaxID(playerid, hslot)
{
	new tmpcount;
	if(hslot < 1 && hslot > MAX_DEALERSHIP) return -1;
	foreach(new drid : Houses)
	{
	    if(!strcmp(pData[playerid][pName], DealerData[drid][dealerOwner], true))
	    {
     		tmpcount++;
       		if(tmpcount == hslot)
       		{
        		return drid;
  			}
	    }
	}
	return -1;
}
