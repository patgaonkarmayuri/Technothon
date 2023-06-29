–
YD:\DocumentService\Technothon\Techonothon-API\DocumentServiceAPI\Constants\AWSContants.cs
	namespace 	
DocumentServiceAPI
 
. 
	Constants &
{ 
public 

static 
class 
AWSContants #
{		 
public

 
const

 
string

 

BucketName

 &
=

' (
$str

) <
;

< =
public 
const 
string 
	AccessKey %
=& '
$str( >
;> ?
public 
const 
string 
	SecretKey %
=& '
$str( R
;R S
public 
static 
string 
DynamoDbTableName .
=/ 0
$str1 F
;F G
public 
static 
Amazon 
. 
RegionEndpoint +
Region, 2
=3 4
Amazon5 ;
.; <
RegionEndpoint< J
.J K
USEast1K R
;R S
} 
} ö
eD:\DocumentService\Technothon\Techonothon-API\DocumentServiceAPI\Constants\DocumentServiceMessages.cs
	namespace 	
DocumentServiceAPI
 
. 
	Constants &
{ 
public 

static 
class #
DocumentServiceMessages /
{		 
public

	 
const

 
string

 
	EmptyFile

 &
=

' (
$str

) 5
;

5 6
public	 
const 
string 
InvalidFile (
=) *
$str+ 9
;9 :
public	 
const 
string 
ExceptionOccured -
=. /
$str0 C
;C D
public 
const 
string 
UploadSuccess )
=* +
$str, L
;L M
public 
const 
string 
UploadFailed (
=) *
$str+ C
;C D
public 
const 
string 
ApplicationIdExist .
=/ 0
$str1 O
;O P
public 
const 
string 
FileNameExist )
=* +
$str, E
;E F
public 
const 
string  
InvalidApplicationId 0
=1 2
$str3 J
;J K
public 
const 
string 
InvalidClientId +
=, -
$str. @
;@ A
} 
} úT
iD:\DocumentService\Technothon\Techonothon-API\DocumentServiceAPI\Controllers\DocumentServiceController.cs
	namespace 	
DocumentServiceAPI
 
. 
Controllers (
{ 
[ 
ApiController 
] 
[ 
Route 

(
 
$str 
) 
] 
public 

class %
DocumentServiceController *
:+ ,
ControllerBase- ;
{ 
private 
readonly 
IConfiguration '
_config( /
;/ 0
private 
readonly 
IAWSClientService *
_clientService+ 9
;9 :
private 
object 
objResponseJson &
=' (
new) ,
object- 3
(3 4
)4 5
;5 6
public %
DocumentServiceController (
(( )
IAWSClientService) :
clientService; H
,H I
IConfigurationI W
configX ^
)^ _
{ 	
_clientService 
= 
clientService *
;* +
_config 
= 
config 
; 
} 	
[ 	
HttpPost	 
] 
[ 	
Route	 
( 
$str 
)  
]  !
public 
async 
Task 
< 
IActionResult '
>' (
UploadDocument) 7
(7 8
[8 9
FromForm9 A
]A B
UploadDocumentModelB U
uploadDocumentModelV i
)i j
{   	
try!! 
{"" 
if## 
(## 
uploadDocumentModel## '
.##' (
File##( ,
==##- /
null##0 4
||##5 7
uploadDocumentModel##8 K
.##K L
File##L P
.##P Q
Length##Q W
==##X Z
$num##[ \
)##\ ]
{$$ 
objResponseJson%% #
=%%$ %
JsonConvert%%& 1
.%%1 2
SerializeObject%%2 A
(%%A B
new%%B E
{%%F G
Message%%H O
=%%O P#
DocumentServiceMessages%%P g
.%%g h
InvalidFile%%h s
,%%s t
Status%%t z
=%%{ |
false	%%} Ç
}
%%Ç É
)
%%É Ñ
;
%%Ñ Ö
}&& 
if'' 
('' 
string'' 
.'' 
IsNullOrEmpty'' (
(''( )
uploadDocumentModel'') <
.''< =
ClientId''= E
)''E F
)''F G
{(( 
objResponseJson)) #
=))$ %
JsonConvert))& 1
.))1 2
SerializeObject))2 A
())A B
new))B E
{))F G
Message))H O
=))O P#
DocumentServiceMessages))P g
.))g h
InvalidClientId))h w
,))w x
Status))x ~
=	)) Ä
false
))Å Ü
}
))Ü á
)
))á à
;
))à â
}** 
bool,, 
	fileExist,, 
=,,  
CheckFileNameExist,,! 3
(,,3 4
uploadDocumentModel,,4 G
.,,G H
File,,H L
!,,L M
.,,M N
FileName,,N V
),,V W
;,,W X
if.. 
(.. 
	fileExist.. 
).. 
{.. 
objResponseJson// #
=//$ %
JsonConvert//& 1
.//1 2
SerializeObject//2 A
(//A B
new//B E
{//F G
Message//H O
=//O P#
DocumentServiceMessages//P g
.//g h
FileNameExist//h u
,//u v
Status//v |
=//} ~
false	// Ñ
}
//Ñ Ö
)
//Ö Ü
;
//Ü á
return00 
Ok00 
(00 
objResponseJson00 -
)00- .
;00. /
}11 
var33 
updateResponse33 "
=33# $
await33% *
UploadFileToS333+ 9
(339 :
uploadDocumentModel33: M
.33M N
File33N R
)33R S
;33S T
if55 
(55 
Convert55 
.55 
	ToBoolean55 %
(55% &
updateResponse55& 4
)554 5
)555 6
{556 7
var77 
addMetadataResponse77 +
=77, -
await77. 3
_clientService774 B
.77B C"
AddItemToDynamoDbAsync77C Y
(77Y Z
uploadDocumentModel77Z m
)77m n
;77n o
if88 
(88 
addMetadataResponse88 +
)88+ ,
{88, -
objResponseJson99 '
=99( )
JsonConvert99* 5
.995 6
SerializeObject996 E
(99E F
new99F I
{99J K
Message99L S
=99S T#
DocumentServiceMessages99T k
.99k l
UploadSuccess99l y
,99y z
Status	99z Ä
=
99Å Ç
true
99É á
}
99á à
)
99à â
;
99â ä
}:: 
else;; 
{;; 
var== 
deleteFileResponse== .
===/ 0
await==1 6
_clientService==7 E
.==E F
DeleteFileAsync==F U
(==U V
uploadDocumentModel==V i
.==i j
File==j n
.==n o
FileName==o w
)==w x
;==x y
objResponseJson>> '
=>>( )
JsonConvert>>* 5
.>>5 6
SerializeObject>>6 E
(>>E F
new>>F I
{>>J K
Message>>L S
=>>S T#
DocumentServiceMessages>>T k
.>>k l
UploadFailed>>l x
,>>x y
Status>>y 
=
>>Ä Å
false
>>Ç á
}
>>á à
)
>>à â
;
>>â ä
}?? 
}@@ 
elseAA 
{AA 
objResponseJsonBB #
=BB$ %
JsonConvertBB& 1
.BB1 2
SerializeObjectBB2 A
(BBA B
newBBB E
{BBF G
MessageBBH O
=BBO P#
DocumentServiceMessagesBBP g
.BBg h
UploadFailedBBh t
,BBt u
StatusBBu {
=BB| }
false	BB~ É
}
BBÉ Ñ
)
BBÑ Ö
;
BBÖ Ü
returnCC 
OkCC 
(CC 
objResponseJsonCC -
)CC- .
;CC. /
}DD 
}EE 
catchFF 
(FF 
	ExceptionFF 
exFF 
)FF  
{GG 
DebugHH 
.HH 
	WriteLineHH 
(HH  
exHH  "
.HH" #
MessageHH# *
)HH* +
;HH+ ,
objResponseJsonII 
=II  !
JsonConvertII" -
.II- .
SerializeObjectII. =
(II= >
newII> A
{IIB C
MessageIID K
=IIL M#
DocumentServiceMessagesIIN e
.IIe f
ExceptionOccuredIIf v
,IIv w
StatusIIw }
=II~ 
false
IIÄ Ö
}
IIÖ Ü
)
IIÜ á
;
IIá à
}JJ 
returnKK 
OkKK 
(KK 
objResponseJsonKK %
)KK% &
;KK& '
}LL 	
[OO 	
HttpGetOO	 
]OO 
[PP 	
RoutePP	 
(PP 
$strPP  
)PP  !
]PP! "
publicQQ 
asyncQQ 
TaskQQ 
<QQ 
IActionResultQQ '
>QQ' ((
SearchItemsFromDynamoDbAsyncQQ) E
(QQE F
)QQF G
{RR 	
trySS 
{TT 
varUU 
itemsUU 
=UU 
awaitUU !
_clientServiceUU" 0
.UU0 1(
SearchItemsFromDynamoDbAsyncUU1 M
(UUM N
)UUN O
;UUO P
returnVV 
OkVV 
(VV 
itemsVV 
)VV  
;VV  !
}WW 
catchXX 
(XX 
	ExceptionXX 
exXX 
)XX  
{YY 
DebugZZ 
.ZZ 
	WriteLineZZ 
(ZZ  
exZZ  "
.ZZ" #
MessageZZ# *
)ZZ* +
;ZZ+ ,
return[[ 

BadRequest[[ !
([[! "
)[[" #
;[[# $
}\\ 
}^^ 	
privateaa 
asyncaa 
Taskaa 
<aa 
boolaa 
>aa  
UploadFileToS3aa! /
(aa/ 0
	IFormFileaa0 9
fileaa: >
)aa> ?
{bb 	
trycc 
{dd 
varee 
fileNameee 
=ee )
ContentDispositionHeaderValueee <
.ee< =
Parseee= B
(eeB C
fileeeC G
.eeG H
ContentDispositioneeH Z
)eeZ [
.ee[ \
FileNameee\ d
!eed e
.eee f
Trimeef j
(eej k
$chareek n
)een o
;eeo p
vargg 
streamgg 
=gg 
filegg !
.gg! "
OpenReadStreamgg" 0
(gg0 1
)gg1 2
;gg2 3
varhh 
uploadResponsehh "
=hh# $
awaithh% *
_clientServicehh+ 9
.hh9 :
UploadFileAsynchh: I
(hhI J
streamhhJ P
,hhP Q
fileNamehhR Z
)hhZ [
;hh[ \
returnii 
uploadResponseii %
;ii% &
}jj 
catchkk 
(kk 
	Exceptionkk 
exkk 
)kk  
{ll 
Debugmm 
.mm 
	WriteLinemm 
(mm  
exmm  "
.mm" #
Messagemm# *
)mm* +
;mm+ ,
thrownn 
exnn 
;nn 
}oo 
}pp 	
privatess 
boolss 
CheckFileNameExistss '
(ss' (
stringss( .
filess/ 3
)ss3 4
{tt 	
tryuu 
{vv 
varww 
fileNameExistww !
=ww" #
_clientServiceww$ 2
.ww2 3
IsFileExistAsyncww3 C
(wwC D
filewwD H
)wwH I
.wwI J
ResultwwJ P
;wwP Q
ifxx 
(xx 
fileNameExistxx !
)xx! "
returnyy 
trueyy 
;yy  
elsezz 
return{{ 
false{{  
;{{  !
}|| 
catch}} 
(}} 
	Exception}} 
ex}} 
)}}  
{~~ 
Debug 
. 
	WriteLine 
(  
ex  "
." #
Message# *
)* +
;+ ,
throw
ÄÄ 
;
ÄÄ 
}
ÅÅ 
}
ÇÇ 	
}
ÜÜ 
}áá æ

_D:\DocumentService\Technothon\Techonothon-API\DocumentServiceAPI\Interface\IAWSClientService.cs
	namespace 	
DocumentServiceAPI
 
. 
	Interface &
{ 
public		 

	interface		 
IAWSClientService		 &
{

 
Task 
< 
bool 
> 
UploadFileAsync "
(" #
Stream# )
stream* 0
,0 1
string2 8
fileName9 A
)A B
;B C
Task 
< 
bool 
> "
AddItemToDynamoDbAsync )
() *
UploadDocumentModel* =
uploadDocumentModel> Q
)Q R
;R S
Task 
< 
List 
< 
GetDocumentModel "
>" #
># $(
SearchItemsFromDynamoDbAsync% A
(A B
)B C
;C D
Task 
< 
bool 
> 
IsFileExistAsync #
(# $
string$ *
file+ /
)/ 0
;0 1
Task 
< 
bool 
> 
DeleteFileAsync "
(" #
string# )
fileName* 2
)2 3
;3 4
} 
} ˘
ZD:\DocumentService\Technothon\Techonothon-API\DocumentServiceAPI\Model\GetDocumentModel.cs
	namespace 	
DocumentServiceAPI
 
. 
Model "
{ 
public 

class 
GetDocumentModel !
{		 
public

 
string

 
?

 
ApplicationId

 $
{

% &
get

' *
;

* +
set

, /
;

/ 0
}

1 2
public 
string 
? 
ClientId 
{  !
get" %
;% &
set' *
;* +
}, -
public 
string 
?  
StatementDescription +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
public 
string 
? 
File 
{ 
get !
;! "
set# &
;& '
}( )
public 
string 
? 
FileURL 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
string 
? 
CreationDate #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 
string 
?  
FormatedCreationDate +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
} 
} ¬
]D:\DocumentService\Technothon\Techonothon-API\DocumentServiceAPI\Model\UploadDocumentModel.cs
	namespace 	
DocumentServiceAPI
 
. 
Model "
{ 
public 

class 
UploadDocumentModel $
{		 
public

 
string

 
?

 
ClientId

 
{

  !
get

" %
;

% &
set

' *
;

* +
}

, -
public 
string 
?  
StatementDescription +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
public 
	IFormFile 
? 
File 
{  
get! $
;$ %
set& )
;) *
}+ ,
} 
} ô
KD:\DocumentService\Technothon\Techonothon-API\DocumentServiceAPI\Program.cs
var 
builder 
= 
WebApplication 
. 
CreateBuilder *
(* +
args+ /
)/ 0
;0 1
builder 
. 
Services 
. 
AddControllers 
(  
)  !
;! "
builder

 
.

 
Services

 
.

 #
AddEndpointsApiExplorer

 (
(

( )
)

) *
;

* +
builder 
. 
Services 
. 
AddSwaggerGen 
( 
)  
;  !
builder 
. 
Services 
. 
	AddScoped 
< 
IAWSClientService ,
,, -
AWSClientService. >
>> ?
(? @
)@ A
;A B
builder 
. 
Services 
. 
AddCors 
( 
options  
=>! #
{ 
options 
. 
	AddPolicy 
( 
$str  
,  !
builder 
=> 
builder 
. 
AllowAnyOrigin )
() *
)* +
)+ ,
;, -
} 
) 
; 
var 
app 
= 	
builder
 
. 
Build 
( 
) 
; 
if 
( 
app 
. 
Environment 
. 
IsDevelopment !
(! "
)" #
)# $
{ 
app 
. 

UseSwagger 
( 
) 
; 
app 
. 
UseSwaggerUI 
( 
) 
; 
} 
app 
. 
UseHttpsRedirection 
( 
) 
; 
app 
. 

UseRouting 
( 
) 
; 
app!! 
.!! 
UseCors!! 
(!! 
$str!! 
)!! 
;!! 
app## 
.## 
UseAuthorization## 
(## 
)## 
;## 
app%% 
.%% 
MapControllers%% 
(%% 
)%% 
;%% 
app'' 
.'' 
Run'' 
('' 
)'' 	
;''	 
‹•
\D:\DocumentService\Technothon\Techonothon-API\DocumentServiceAPI\Service\AWSClientService.cs
	namespace

 	
DocumentServiceAPI


 
.

 
Service

 $
{ 
public 

class 
AWSClientService !
:" #
IAWSClientService$ 5
{ 
private 
static 
readonly 
	IAmazonS3  )
	_s3Client* 3
=4 5
new6 9
AmazonS3Client: H
(H I
AWSContantsI T
.T U
	AccessKeyU ^
,^ _
AWSContants 
. 
	SecretKey !
,! "
AWSContants 
. 
Region 
) 
;  
private 
static 
readonly  
AmazonDynamoDBClient  4
_dynamoDBClient5 D
=E F
newG J 
AmazonDynamoDBClientK _
(_ `
AWSContants` k
.k l
	AccessKeyl u
,u v
AWSContants 
. 
	SecretKey !
,! "
AWSContants 
. 
Region 
) 
;  
public 
async 
Task 
< 
bool 
> 
UploadFileAsync  /
(/ 0
Stream0 6
stream7 =
,= >
string? E
fileNameF N
)N O
{ 	
try 
{ 
var 

putRequest 
=  
new! $
PutObjectRequest% 5
{ 

BucketName 
=  
AWSContants! ,
., -

BucketName- 7
,7 8
Key 
= 
fileName "
," #
InputStream 
=  !
stream" (
} 
; 
var   
response   
=   
await   $
	_s3Client  % .
.  . /
PutObjectAsync  / =
(  = >

putRequest  > H
)  H I
;  I J
return!! 
true!! 
;!! 
}"" 
catch## 
(## 
	Exception## 
)## 
{$$ 
throw%% 
;%% 
}&& 
}'' 	
private** 
string** 
GetPreSignedUrl** &
(**& '
string**' -
fileName**. 6
)**6 7
{++ 	
try,, 
{-- 
var.. 
request.. 
=.. 
new.. !"
GetPreSignedUrlRequest.." 8
{// 

BucketName00 
=00  
AWSContants00! ,
.00, -

BucketName00- 7
,007 8
Key11 
=11 
fileName11 "
,11" #
Expires22 
=22 
DateTime22 &
.22& '
Now22' *
.22* +
AddDays22+ 2
(222 3
$num223 4
)224 5
}33 
;33 
return44 
	_s3Client44  
.44  !
GetPreSignedURL44! 0
(440 1
request441 8
)448 9
;449 :
}55 
catch66 
(66 
	Exception66 
)66 
{77 
throw88 
;88 
}99 
}:: 	
public== 
async== 
Task== 
<== 
bool== 
>== "
AddItemToDynamoDbAsync==  6
(==6 7
UploadDocumentModel==7 J
uploadDocumentModel==K ^
)==^ _
{>> 	
try?? 
{@@ 
objectAA 
ApplicationIdAA $
=AA% &!
GenerateApplicationIdAA' <
(AA< =
)AA= >
;AA> ?
objectCC 
CreationDateCC #
=CC$ %
DateTimeCC& .
.CC. /
NowCC/ 2
.CC2 3
ToStringCC3 ;
(CC; <
$strCC< Q
,CCQ R
SystemCCR X
.CCX Y
GlobalizationCCY f
.CCf g
CultureInfoCCg r
.CCr s
InvariantCulture	CCs É
)
CCÉ Ñ
;
CCÑ Ö
varEE 

putRequestEE 
=EE  
newEE! $
PutItemRequestEE% 3
{FF 
	TableNameGG 
=GG 
AWSContantsGG  +
.GG+ ,
DynamoDbTableNameGG, =
,GG= >
ItemHH 
=HH 
newHH 

DictionaryHH )
<HH) *
stringHH* 0
,HH0 1
AttributeValueHH2 @
>HH@ A
{II 
{JJ 
nameofJJ  
(JJ  !
ApplicationIdJJ! .
)JJ. /
,JJ/ 0
newJJ1 4
AttributeValueJJ5 C
{JJD E
SJJF G
=JJH I
ApplicationIdJJJ W
.JJW X
ToStringJJX `
(JJ` a
)JJa b
}JJc d
}JJe f
,JJf g
{KK 
nameofKK  
(KK  !
uploadDocumentModelKK! 4
.KK4 5
ClientIdKK5 =
)KK= >
,KK> ?
newKK@ C
AttributeValueKKD R
{KKS T
SKKU V
=KKW X
uploadDocumentModelKKY l
.KKl m
ClientIdKKm u
==KKv x
nullKKy }
?KK} ~
$str	KK Å
:
KKÅ Ç!
uploadDocumentModel
KKÉ ñ
.
KKñ ó
ClientId
KKó ü
}
KKü †
}
KK° ¢
,
KK¢ £
{LL 
nameofLL  
(LL  !
uploadDocumentModelLL! 4
.LL4 5
FileLL5 9
)LL9 :
,LL: ;
newLL< ?
AttributeValueLL@ N
{LLO P
SLLQ R
=LLS T
uploadDocumentModelLLU h
.LLh i
FileLLi m
!LLm n
.LLn o
FileNameLLo w
}LLx y
}LLz {
,LL{ |
{MM 
nameofMM  
(MM  !
uploadDocumentModelMM! 4
.MM4 5 
StatementDescriptionMM5 I
)MMI J
,MMJ K
newMML O
AttributeValueMMP ^
{MM_ `
SMMa b
=MMc d
uploadDocumentModelMMe x
.MMx y!
StatementDescription	MMy ç
==
MMç è
null
MMè ì
?
MMì î
$str
MMï ó
:
MMó ò!
uploadDocumentModel
MMò ´
.
MM´ ¨"
StatementDescription
MM¨ ¿
}
MM¡ ¬
}
MM√ ƒ
,
MMƒ ≈
{NN 
nameofNN  
(NN  !
CreationDateNN! -
)NN- .
,NN. /
newNN0 3
AttributeValueNN4 B
{NNC D
SNNE F
=NNG H
CreationDateNNI U
.NNU V
ToStringNNV ^
(NN^ _
)NN_ `
}NNa b
}NNc d
}PP 
}QQ 
;QQ 
varRR 
responseRR 
=RR 
awaitRR $
_dynamoDBClientRR% 4
.RR4 5
PutItemAsyncRR5 A
(RRA B

putRequestRRB L
)RRL M
;RRM N
returnSS 
trueSS 
;SS 
}TT 
catchUU 
(UU 
	ExceptionUU 
)UU 
{VV 
throwWW 
;WW 
}XX 
}ZZ 	
public]] 
async]] 
Task]] 
<]] 
List]] 
<]] 
GetDocumentModel]] /
>]]/ 0
>]]0 1%
GetItemsFromDynamoDbAsync]]2 K
(]]K L
)]]L M
{^^ 	
try__ 
{`` 
varaa 
requestaa 
=aa 
newaa !
ScanRequestaa" -
{bb 
	TableNamecc 
=cc 
AWSContantscc  +
.cc+ ,
DynamoDbTableNamecc, =
}dd 
;dd 
varee 
responseee 
=ee 
awaitee $
_dynamoDBClientee% 4
.ee4 5
	ScanAsyncee5 >
(ee> ?
requestee? F
)eeF G
;eeG H
varff 
getDocumentModelsff %
=ff& '
responseff( 0
.ff0 1
Itemsff1 6
.ff6 7
Selectff7 =
(ff= >
iff> ?
=>ff@ B
newffC F
GetDocumentModelffG W
{gg 
ApplicationIdhh !
=hh" #
ihh$ %
[hh% &
nameofhh& ,
(hh, -
GetDocumentModelhh- =
.hh= >
ApplicationIdhh> K
)hhK L
]hhL M
.hhM N
ShhN O
,hhO P
ClientIdii 
=ii 
iii  
[ii  !
nameofii! '
(ii' (
GetDocumentModelii( 8
.ii8 9
ClientIdii9 A
)iiA B
]iiB C
.iiC D
SiiD E
,iiE F
Filejj 
=jj 
ijj 
[jj 
nameofjj #
(jj# $
GetDocumentModeljj$ 4
.jj4 5
Filejj5 9
)jj9 :
]jj: ;
.jj; <
Sjj< =
,jj= > 
StatementDescriptionkk (
=kk) *
ikk+ ,
[kk, -
nameofkk- 3
(kk3 4
GetDocumentModelkk4 D
.kkD E 
StatementDescriptionkkE Y
)kkY Z
]kkZ [
.kk[ \
Skk\ ]
}ll 
)ll 
.ll 
ToListll 
(ll 
)ll 
;ll 
returnmm 
getDocumentModelsmm (
;mm( )
}nn 
catchoo 
(oo 
	Exceptionoo 
)oo 
{pp 
throwqq 
;qq 
}rr 
}ss 	
publicvv 
asyncvv 
Taskvv 
<vv 
Listvv 
<vv 
GetDocumentModelvv /
>vv/ 0
>vv0 1(
SearchItemsFromDynamoDbAsyncvv2 N
(vvN O
)vvO P
{ww 	
tryxx 
{yy 
varzz 
requestzz 
=zz 
newzz !
ScanRequestzz" -
{{{ 
	TableName|| 
=|| 
AWSContants||  +
.||+ ,
DynamoDbTableName||, =
}}} 
;}} 
var~~ 
response~~ 
=~~ 
await~~ $
_dynamoDBClient~~% 4
.~~4 5
	ScanAsync~~5 >
(~~> ?
request~~? F
)~~F G
;~~G H
var 
getDocumentsModel %
=& '
response( 0
.0 1
Items1 6
.6 7
Select7 =
(= >
i> ?
=>@ B
newC F
GetDocumentModelG W
{
ÄÄ 
ApplicationId
ÅÅ !
=
ÅÅ" #
i
ÅÅ$ %
[
ÅÅ% &
nameof
ÅÅ& ,
(
ÅÅ, -
GetDocumentModel
ÅÅ- =
.
ÅÅ= >
ApplicationId
ÅÅ> K
)
ÅÅK L
]
ÅÅL M
.
ÅÅM N
S
ÅÅN O
,
ÅÅO P
ClientId
ÇÇ 
=
ÇÇ 
i
ÇÇ  
[
ÇÇ  !
nameof
ÇÇ! '
(
ÇÇ' (
GetDocumentModel
ÇÇ( 8
.
ÇÇ8 9
ClientId
ÇÇ9 A
)
ÇÇA B
]
ÇÇB C
.
ÇÇC D
S
ÇÇD E
,
ÇÇE F
File
ÉÉ 
=
ÉÉ 
i
ÉÉ 
[
ÉÉ 
nameof
ÉÉ #
(
ÉÉ# $
GetDocumentModel
ÉÉ$ 4
.
ÉÉ4 5
File
ÉÉ5 9
)
ÉÉ9 :
]
ÉÉ: ;
.
ÉÉ; <
S
ÉÉ< =
,
ÉÉ= >"
StatementDescription
ÑÑ (
=
ÑÑ) *
i
ÑÑ+ ,
[
ÑÑ, -
nameof
ÑÑ- 3
(
ÑÑ3 4
GetDocumentModel
ÑÑ4 D
.
ÑÑD E"
StatementDescription
ÑÑE Y
)
ÑÑY Z
]
ÑÑZ [
.
ÑÑ[ \
S
ÑÑ\ ]
,
ÑÑ] ^
FileURL
ÖÖ 
=
ÖÖ 
GetPreSignedUrl
ÖÖ -
(
ÖÖ- .
i
ÖÖ. /
[
ÖÖ/ 0
nameof
ÖÖ0 6
(
ÖÖ6 7
GetDocumentModel
ÖÖ7 G
.
ÖÖG H
File
ÖÖH L
)
ÖÖL M
]
ÖÖM N
.
ÖÖN O
S
ÖÖO P
)
ÖÖP Q
,
ÖÖQ R
CreationDate
ÜÜ  
=
ÜÜ! "
i
ÜÜ# $
[
ÜÜ$ %
nameof
ÜÜ% +
(
ÜÜ+ ,
GetDocumentModel
ÜÜ, <
.
ÜÜ< =
CreationDate
ÜÜ= I
)
ÜÜI J
]
ÜÜJ K
.
ÜÜK L
S
ÜÜL M
,
ÜÜM N"
FormatedCreationDate
áá (
=
áá) *
DateTime
áá+ 3
.
áá3 4

ParseExact
áá4 >
(
áá> ?
i
áá? @
[
áá@ A
nameof
ááA G
(
ááG H
GetDocumentModel
ááH X
.
ááX Y
CreationDate
ááY e
)
ááe f
]
ááf g
.
áág h
S
ááh i
,
áái j
$str
ááj 
,áá Ä
SystemááÄ Ü
.ááÜ á
Globalizationááá î
.ááî ï
CultureInfoááï †
.áá† ° 
InvariantCultureáá° ±
)áá± ≤
.áá≤ ≥
ToStringáá≥ ª
(ááª º
$strááº »
,áá» …
Systemáá… œ
.ááœ –
Globalizationáá– ›
.áá› ﬁ
CultureInfoááﬁ È
.ááÈ Í 
InvariantCultureááÍ ˙
)áá˙ ˚
}
àà 
)
àà 
.
àà 
OrderBy
àà 
(
àà 
x
àà 
=>
àà 
DateTime
àà  (
.
àà( )

ParseExact
àà) 3
(
àà3 4
x
àà4 5
.
àà5 6
CreationDate
àà6 B
!
ààB C
,
ààC D
$str
ààD Y
,
ààY Z
System
ààZ `
.
àà` a
Globalization
ààa n
.
ààn o
CultureInfo
àào z
.
ààz {
InvariantCultureàà{ ã
)ààã å
)ààå ç
.
ââ 
ToList
ââ 
(
ââ 
)
ââ 
;
ââ 
return
ãã 
getDocumentsModel
ãã (
;
ãã( )
}
åå 
catch
çç 
(
çç 
	Exception
çç 
)
çç 
{
éé 
throw
èè 
;
èè 
}
êê 
}
ëë 	
public
îî 
async
îî 
Task
îî 
<
îî 
bool
îî 
>
îî '
IsApplicationIdExistAsync
îî  9
(
îî9 :
string
îî: @
applicationId
îîA N
)
îîN O
{
ïï 	
try
ññ 
{
óó 
var
òò 
request
òò 
=
òò 
new
òò !
ScanRequest
òò" -
{
ôô 
	TableName
öö 
=
öö 
AWSContants
öö  +
.
öö+ ,
DynamoDbTableName
öö, =
}
õõ 
;
õõ 
var
úú 
response
úú 
=
úú 
await
úú $
_dynamoDBClient
úú% 4
.
úú4 5
	ScanAsync
úú5 >
(
úú> ?
request
úú? F
)
úúF G
;
úúG H
if
ùù 
(
ùù 
response
ùù 
.
ùù 
Items
ùù !
.
ùù! "
ToList
ùù" (
(
ùù( )
)
ùù) *
.
ùù* +
Count
ùù+ 0
==
ùù2 4
$num
ùù5 6
)
ùù6 7
{
ûû 
return
üü 
false
üü  
;
üü  !
}
†† 
var
°° 
getDocumentModels
°° %
=
°°& '
response
°°( 0
.
°°0 1
Items
°°1 6
.
°°6 7
Select
°°7 =
(
°°= >
i
°°> ?
=>
°°@ B
new
°°C F
GetDocumentModel
°°G W
{
¢¢ 
ApplicationId
££ !
=
££" #
i
££$ %
[
££% &
nameof
££& ,
(
££, -
ApplicationId
££- :
)
££: ;
]
££; <
.
££< =
S
££= >
}
§§ 
)
§§ 
.
§§ 
ToList
§§ 
(
§§ 
)
§§ 
;
§§ 
var
¶¶ 
checkItemExist
¶¶ "
=
¶¶# $
getDocumentModels
¶¶% 6
.
¶¶6 7
Any
¶¶7 :
(
¶¶: ;
x
¶¶; <
=>
¶¶= ?
x
¶¶@ A
.
¶¶A B
ApplicationId
¶¶B O
==
¶¶P R
applicationId
¶¶S `
)
¶¶` a
;
¶¶a b
return
ßß 
checkItemExist
ßß %
;
ßß% &
}
®® 
catch
©© 
(
©© 
	Exception
©© 
)
©© 
{
™™ 
throw
´´ 
;
´´ 
}
¨¨ 
}
≠≠ 	
public
∞∞ 
async
∞∞ 
Task
∞∞ 
<
∞∞ 
bool
∞∞ 
>
∞∞ 
IsFileExistAsync
∞∞  0
(
∞∞0 1
string
∞∞1 7
file
∞∞8 <
)
∞∞< =
{
±± 	
try
≤≤ 
{
≥≥ 
var
¥¥ 
request
¥¥ 
=
¥¥ 
new
¥¥ !
ScanRequest
¥¥" -
{
µµ 
	TableName
∂∂ 
=
∂∂ 
AWSContants
∂∂  +
.
∂∂+ ,
DynamoDbTableName
∂∂, =
}
∑∑ 
;
∑∑ 
var
∏∏ 
response
∏∏ 
=
∏∏ 
await
∏∏ $
_dynamoDBClient
∏∏% 4
.
∏∏4 5
	ScanAsync
∏∏5 >
(
∏∏> ?
request
∏∏? F
)
∏∏F G
;
∏∏G H
if
ππ 
(
ππ 
response
ππ 
.
ππ 
Items
ππ !
.
ππ! "
ToList
ππ" (
(
ππ( )
)
ππ) *
.
ππ* +
Count
ππ+ 0
==
ππ2 4
$num
ππ5 6
)
ππ6 7
{
∫∫ 
return
ªª 
false
ªª  
;
ªª  !
}
ºº 
var
ΩΩ 
getDocumentModels
ΩΩ %
=
ΩΩ& '
response
ΩΩ( 0
.
ΩΩ0 1
Items
ΩΩ1 6
.
ΩΩ6 7
Select
ΩΩ7 =
(
ΩΩ= >
i
ΩΩ> ?
=>
ΩΩ@ B
new
ΩΩC F
GetDocumentModel
ΩΩG W
{
ææ 
File
øø 
=
øø 
i
øø 
[
øø 
nameof
øø #
(
øø# $
File
øø$ (
)
øø( )
]
øø) *
.
øø* +
S
øø+ ,
}
¿¿ 
)
¿¿ 
.
¿¿ 
ToList
¿¿ 
(
¿¿ 
)
¿¿ 
;
¿¿ 
var
¬¬ 
checkItemExist
¬¬ "
=
¬¬# $
getDocumentModels
¬¬% 6
.
¬¬6 7
Any
¬¬7 :
(
¬¬: ;
x
¬¬; <
=>
¬¬= ?
x
¬¬@ A
.
¬¬A B
File
¬¬B F
==
¬¬G I
file
¬¬J N
)
¬¬N O
;
¬¬O P
return
√√ 
checkItemExist
√√ %
;
√√% &
}
ƒƒ 
catch
≈≈ 
(
≈≈ 
	Exception
≈≈ 
)
≈≈ 
{
∆∆ 
throw
«« 
;
«« 
}
»» 
}
…… 	
public
ÃÃ 
async
ÃÃ 
Task
ÃÃ 
<
ÃÃ 
bool
ÃÃ 
>
ÃÃ 
DeleteFileAsync
ÃÃ  /
(
ÃÃ/ 0
string
ÃÃ0 6
fileName
ÃÃ7 ?
)
ÃÃ? @
{
ÕÕ 	
try
ŒŒ 
{
œœ 
var
–– 
deleteRequest
–– !
=
––" #
new
––$ '!
DeleteObjectRequest
––( ;
{
—— 

BucketName
““ 
=
““  
AWSContants
““! ,
.
““, -

BucketName
““- 7
,
““7 8
Key
”” 
=
”” 
fileName
”” "
}
‘‘ 
;
‘‘ 
var
’’ 
response
’’ 
=
’’ 
await
’’ $
	_s3Client
’’% .
.
’’. /
DeleteObjectAsync
’’/ @
(
’’@ A
deleteRequest
’’A N
)
’’N O
;
’’O P
return
÷÷ 
true
÷÷ 
;
÷÷ 
}
◊◊ 
catch
ÿÿ 
(
ÿÿ 
	Exception
ÿÿ 
)
ÿÿ 
{
ŸŸ 
throw
⁄⁄ 
;
⁄⁄ 
}
€€ 
}
‹‹ 	
private
ﬂﬂ 
string
ﬂﬂ #
GenerateApplicationId
ﬂﬂ ,
(
ﬂﬂ, -
)
ﬂﬂ- .
{
‡‡ 	
try
·· 
{
‚‚ 
var
„„ 
applicationId
„„ !
=
„„" #
Guid
„„$ (
.
„„( )
NewGuid
„„) 0
(
„„0 1
)
„„1 2
.
„„2 3
ToString
„„3 ;
(
„„; <
)
„„< =
;
„„= >
bool
‰‰  
applicationIdExist
‰‰ (
=
‰‰) *'
IsApplicationIdExistAsync
‰‰+ D
(
‰‰D E
applicationId
‰‰E R
)
‰‰R S
.
‰‰S T
Result
‰‰T Z
;
‰‰Z [
if
ÊÊ 
(
ÊÊ  
applicationIdExist
ÊÊ %
)
ÊÊ% &
return
ÁÁ #
GenerateApplicationId
ÁÁ 0
(
ÁÁ0 1
)
ÁÁ1 2
;
ÁÁ2 3
else
ËË 
return
ÈÈ 
applicationId
ÈÈ (
;
ÈÈ( )
}
ÍÍ 
catch
ÎÎ 
(
ÎÎ 
	Exception
ÎÎ 
ex
ÎÎ 
)
ÎÎ  
{
ÏÏ 
Debug
ÌÌ 
.
ÌÌ 
	WriteLine
ÌÌ 
(
ÌÌ  
ex
ÌÌ  "
.
ÌÌ" #
Message
ÌÌ# *
)
ÌÌ* +
;
ÌÌ+ ,
throw
ÓÓ 
;
ÓÓ 
}
ÔÔ 
}
ÒÒ 	
}
ÚÚ 
}ÛÛ 