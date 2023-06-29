�
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
} �
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
} �T
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
false	%%} �
}
%%� �
)
%%� �
;
%%� �
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
=	)) �
false
))� �
}
))� �
)
))� �
;
))� �
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
false	// �
}
//� �
)
//� �
;
//� �
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
Status	99z �
=
99� �
true
99� �
}
99� �
)
99� �
;
99� �
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
>>� �
false
>>� �
}
>>� �
)
>>� �
;
>>� �
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
false	BB~ �
}
BB� �
)
BB� �
;
BB� �
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
II� �
}
II� �
)
II� �
;
II� �
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
�� 
;
�� 
}
�� 
}
�� 	
}
�� 
}�� �

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
} �
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
} �
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
} �
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
ܥ
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
InvariantCulture	CCs �
)
CC� �
;
CC� �
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
$str	KK �
:
KK� �!
uploadDocumentModel
KK� �
.
KK� �
ClientId
KK� �
}
KK� �
}
KK� �
,
KK� �
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
StatementDescription	MMy �
==
MM� �
null
MM� �
?
MM� �
$str
MM� �
:
MM� �!
uploadDocumentModel
MM� �
.
MM� �"
StatementDescription
MM� �
}
MM� �
}
MM� �
,
MM� �
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
�� 
ApplicationId
�� !
=
��" #
i
��$ %
[
��% &
nameof
��& ,
(
��, -
GetDocumentModel
��- =
.
��= >
ApplicationId
��> K
)
��K L
]
��L M
.
��M N
S
��N O
,
��O P
ClientId
�� 
=
�� 
i
��  
[
��  !
nameof
��! '
(
��' (
GetDocumentModel
��( 8
.
��8 9
ClientId
��9 A
)
��A B
]
��B C
.
��C D
S
��D E
,
��E F
File
�� 
=
�� 
i
�� 
[
�� 
nameof
�� #
(
��# $
GetDocumentModel
��$ 4
.
��4 5
File
��5 9
)
��9 :
]
��: ;
.
��; <
S
��< =
,
��= >"
StatementDescription
�� (
=
��) *
i
��+ ,
[
��, -
nameof
��- 3
(
��3 4
GetDocumentModel
��4 D
.
��D E"
StatementDescription
��E Y
)
��Y Z
]
��Z [
.
��[ \
S
��\ ]
,
��] ^
FileURL
�� 
=
�� 
GetPreSignedUrl
�� -
(
��- .
i
��. /
[
��/ 0
nameof
��0 6
(
��6 7
GetDocumentModel
��7 G
.
��G H
File
��H L
)
��L M
]
��M N
.
��N O
S
��O P
)
��P Q
,
��Q R
CreationDate
��  
=
��! "
i
��# $
[
��$ %
nameof
��% +
(
��+ ,
GetDocumentModel
��, <
.
��< =
CreationDate
��= I
)
��I J
]
��J K
.
��K L
S
��L M
,
��M N"
FormatedCreationDate
�� (
=
��) *
DateTime
��+ 3
.
��3 4

ParseExact
��4 >
(
��> ?
i
��? @
[
��@ A
nameof
��A G
(
��G H
GetDocumentModel
��H X
.
��X Y
CreationDate
��Y e
)
��e f
]
��f g
.
��g h
S
��h i
,
��i j
$str
��j 
,�� �
System��� �
.��� �
Globalization��� �
.��� �
CultureInfo��� �
.��� � 
InvariantCulture��� �
)��� �
.��� �
ToString��� �
(��� �
$str��� �
,��� �
System��� �
.��� �
Globalization��� �
.��� �
CultureInfo��� �
.��� � 
InvariantCulture��� �
)��� �
}
�� 
)
�� 
.
�� 
OrderBy
�� 
(
�� 
x
�� 
=>
�� 
DateTime
��  (
.
��( )

ParseExact
��) 3
(
��3 4
x
��4 5
.
��5 6
CreationDate
��6 B
!
��B C
,
��C D
$str
��D Y
,
��Y Z
System
��Z `
.
��` a
Globalization
��a n
.
��n o
CultureInfo
��o z
.
��z {
InvariantCulture��{ �
)��� �
)��� �
.
�� 
ToList
�� 
(
�� 
)
�� 
;
�� 
return
�� 
getDocumentsModel
�� (
;
��( )
}
�� 
catch
�� 
(
�� 
	Exception
�� 
)
�� 
{
�� 
throw
�� 
;
�� 
}
�� 
}
�� 	
public
�� 
async
�� 
Task
�� 
<
�� 
bool
�� 
>
�� '
IsApplicationIdExistAsync
��  9
(
��9 :
string
��: @
applicationId
��A N
)
��N O
{
�� 	
try
�� 
{
�� 
var
�� 
request
�� 
=
�� 
new
�� !
ScanRequest
��" -
{
�� 
	TableName
�� 
=
�� 
AWSContants
��  +
.
��+ ,
DynamoDbTableName
��, =
}
�� 
;
�� 
var
�� 
response
�� 
=
�� 
await
�� $
_dynamoDBClient
��% 4
.
��4 5
	ScanAsync
��5 >
(
��> ?
request
��? F
)
��F G
;
��G H
if
�� 
(
�� 
response
�� 
.
�� 
Items
�� !
.
��! "
ToList
��" (
(
��( )
)
��) *
.
��* +
Count
��+ 0
==
��2 4
$num
��5 6
)
��6 7
{
�� 
return
�� 
false
��  
;
��  !
}
�� 
var
�� 
getDocumentModels
�� %
=
��& '
response
��( 0
.
��0 1
Items
��1 6
.
��6 7
Select
��7 =
(
��= >
i
��> ?
=>
��@ B
new
��C F
GetDocumentModel
��G W
{
�� 
ApplicationId
�� !
=
��" #
i
��$ %
[
��% &
nameof
��& ,
(
��, -
ApplicationId
��- :
)
��: ;
]
��; <
.
��< =
S
��= >
}
�� 
)
�� 
.
�� 
ToList
�� 
(
�� 
)
�� 
;
�� 
var
�� 
checkItemExist
�� "
=
��# $
getDocumentModels
��% 6
.
��6 7
Any
��7 :
(
��: ;
x
��; <
=>
��= ?
x
��@ A
.
��A B
ApplicationId
��B O
==
��P R
applicationId
��S `
)
��` a
;
��a b
return
�� 
checkItemExist
�� %
;
��% &
}
�� 
catch
�� 
(
�� 
	Exception
�� 
)
�� 
{
�� 
throw
�� 
;
�� 
}
�� 
}
�� 	
public
�� 
async
�� 
Task
�� 
<
�� 
bool
�� 
>
�� 
IsFileExistAsync
��  0
(
��0 1
string
��1 7
file
��8 <
)
��< =
{
�� 	
try
�� 
{
�� 
var
�� 
request
�� 
=
�� 
new
�� !
ScanRequest
��" -
{
�� 
	TableName
�� 
=
�� 
AWSContants
��  +
.
��+ ,
DynamoDbTableName
��, =
}
�� 
;
�� 
var
�� 
response
�� 
=
�� 
await
�� $
_dynamoDBClient
��% 4
.
��4 5
	ScanAsync
��5 >
(
��> ?
request
��? F
)
��F G
;
��G H
if
�� 
(
�� 
response
�� 
.
�� 
Items
�� !
.
��! "
ToList
��" (
(
��( )
)
��) *
.
��* +
Count
��+ 0
==
��2 4
$num
��5 6
)
��6 7
{
�� 
return
�� 
false
��  
;
��  !
}
�� 
var
�� 
getDocumentModels
�� %
=
��& '
response
��( 0
.
��0 1
Items
��1 6
.
��6 7
Select
��7 =
(
��= >
i
��> ?
=>
��@ B
new
��C F
GetDocumentModel
��G W
{
�� 
File
�� 
=
�� 
i
�� 
[
�� 
nameof
�� #
(
��# $
File
��$ (
)
��( )
]
��) *
.
��* +
S
��+ ,
}
�� 
)
�� 
.
�� 
ToList
�� 
(
�� 
)
�� 
;
�� 
var
�� 
checkItemExist
�� "
=
��# $
getDocumentModels
��% 6
.
��6 7
Any
��7 :
(
��: ;
x
��; <
=>
��= ?
x
��@ A
.
��A B
File
��B F
==
��G I
file
��J N
)
��N O
;
��O P
return
�� 
checkItemExist
�� %
;
��% &
}
�� 
catch
�� 
(
�� 
	Exception
�� 
)
�� 
{
�� 
throw
�� 
;
�� 
}
�� 
}
�� 	
public
�� 
async
�� 
Task
�� 
<
�� 
bool
�� 
>
�� 
DeleteFileAsync
��  /
(
��/ 0
string
��0 6
fileName
��7 ?
)
��? @
{
�� 	
try
�� 
{
�� 
var
�� 
deleteRequest
�� !
=
��" #
new
��$ '!
DeleteObjectRequest
��( ;
{
�� 

BucketName
�� 
=
��  
AWSContants
��! ,
.
��, -

BucketName
��- 7
,
��7 8
Key
�� 
=
�� 
fileName
�� "
}
�� 
;
�� 
var
�� 
response
�� 
=
�� 
await
�� $
	_s3Client
��% .
.
��. /
DeleteObjectAsync
��/ @
(
��@ A
deleteRequest
��A N
)
��N O
;
��O P
return
�� 
true
�� 
;
�� 
}
�� 
catch
�� 
(
�� 
	Exception
�� 
)
�� 
{
�� 
throw
�� 
;
�� 
}
�� 
}
�� 	
private
�� 
string
�� #
GenerateApplicationId
�� ,
(
��, -
)
��- .
{
�� 	
try
�� 
{
�� 
var
�� 
applicationId
�� !
=
��" #
Guid
��$ (
.
��( )
NewGuid
��) 0
(
��0 1
)
��1 2
.
��2 3
ToString
��3 ;
(
��; <
)
��< =
;
��= >
bool
��  
applicationIdExist
�� (
=
��) *'
IsApplicationIdExistAsync
��+ D
(
��D E
applicationId
��E R
)
��R S
.
��S T
Result
��T Z
;
��Z [
if
�� 
(
��  
applicationIdExist
�� %
)
��% &
return
�� #
GenerateApplicationId
�� 0
(
��0 1
)
��1 2
;
��2 3
else
�� 
return
�� 
applicationId
�� (
;
��( )
}
�� 
catch
�� 
(
�� 
	Exception
�� 
ex
�� 
)
��  
{
�� 
Debug
�� 
.
�� 
	WriteLine
�� 
(
��  
ex
��  "
.
��" #
Message
��# *
)
��* +
;
��+ ,
throw
�� 
;
�� 
}
�� 
}
�� 	
}
�� 
}�� 