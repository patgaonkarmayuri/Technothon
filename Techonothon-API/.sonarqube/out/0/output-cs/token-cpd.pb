╙
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
AwsContants #
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
public 
const 
string 
DynamoDbTableName -
=. /
$str0 E
;E F
} 
} Ъ
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
} шP
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
readonly 
IAwsClientService *
_clientService+ 9
;9 :
private 
object 
objResponseJson &
=' (
new) ,
object- 3
(3 4
)4 5
;5 6
public %
DocumentServiceController (
(( )
IAwsClientService) :
clientService; H
,H I
IConfigurationI W
configX ^
)^ _
{ 	
_clientService 
= 
clientService *
;* +
} 	
[ 	
HttpPost	 
] 
[ 	
Route	 
( 
$str 
)  
]  !
public 
async 
Task 
< 
IActionResult '
>' (
UploadDocument) 7
(7 8
[8 9
FromForm9 A
]A B
UploadDocumentModelB U
uploadDocumentModelV i
)i j
{ 	
try 
{   
if!! 
(!! 
uploadDocumentModel!! '
.!!' (
File!!( ,
==!!- /
null!!0 4
||!!5 7
uploadDocumentModel!!8 K
.!!K L
File!!L P
.!!P Q
Length!!Q W
==!!X Z
$num!![ \
)!!\ ]
{"" 
objResponseJson## #
=##$ %
JsonConvert##& 1
.##1 2
SerializeObject##2 A
(##A B
new##B E
{##F G
Message##H O
=##O P#
DocumentServiceMessages##P g
.##g h
InvalidFile##h s
,##s t
Status##t z
=##{ |
false	##} В
}
##В Г
)
##Г Д
;
##Д Е
}$$ 
if%% 
(%% 
string%% 
.%% 
IsNullOrEmpty%% (
(%%( )
uploadDocumentModel%%) <
.%%< =
ClientId%%= E
)%%E F
)%%F G
{&& 
objResponseJson'' #
=''$ %
JsonConvert''& 1
.''1 2
SerializeObject''2 A
(''A B
new''B E
{''F G
Message''H O
=''O P#
DocumentServiceMessages''P g
.''g h
InvalidClientId''h w
,''w x
Status''x ~
=	'' А
false
''Б Ж
}
''Ж З
)
''З И
;
''И Й
}(( 
bool** 
	fileExist** 
=**  
CheckFileNameExist**! 3
(**3 4
uploadDocumentModel**4 G
.**G H
File**H L
!**L M
.**M N
FileName**N V
)**V W
;**W X
if,, 
(,, 
	fileExist,, 
),, 
{,, 
objResponseJson-- #
=--$ %
JsonConvert--& 1
.--1 2
SerializeObject--2 A
(--A B
new--B E
{--F G
Message--H O
=--O P#
DocumentServiceMessages--P g
.--g h
FileNameExist--h u
,--u v
Status--v |
=--} ~
false	-- Д
}
--Д Е
)
--Е Ж
;
--Ж З
return.. 
Ok.. 
(.. 
objResponseJson.. -
)..- .
;... /
}// 
var11 
updateResponse11 "
=11# $
await11% *
UploadFileToS311+ 9
(119 :
uploadDocumentModel11: M
.11M N
File11N R
)11R S
;11S T
if33 
(33 
Convert33 
.33 
	ToBoolean33 %
(33% &
updateResponse33& 4
)334 5
)335 6
{336 7
var55 
addMetadataResponse55 +
=55, -
await55. 3
_clientService554 B
.55B C"
AddItemToDynamoDbAsync55C Y
(55Y Z
uploadDocumentModel55Z m
)55m n
;55n o
if66 
(66 
addMetadataResponse66 +
)66+ ,
{66, -
objResponseJson77 '
=77( )
JsonConvert77* 5
.775 6
SerializeObject776 E
(77E F
new77F I
{77J K
Message77L S
=77S T#
DocumentServiceMessages77T k
.77k l
UploadSuccess77l y
,77y z
Status	77z А
=
77Б В
true
77Г З
}
77З И
)
77И Й
;
77Й К
}88 
else99 
{99 
await;; 
_clientService;; ,
.;;, -
DeleteFileAsync;;- <
(;;< =
uploadDocumentModel;;= P
.;;P Q
File;;Q U
.;;U V
FileName;;V ^
);;^ _
;;;_ `
objResponseJson<< '
=<<( )
JsonConvert<<* 5
.<<5 6
SerializeObject<<6 E
(<<E F
new<<F I
{<<J K
Message<<L S
=<<S T#
DocumentServiceMessages<<T k
.<<k l
UploadFailed<<l x
,<<x y
Status<<y 
=
<<А Б
false
<<В З
}
<<З И
)
<<И Й
;
<<Й К
}== 
}>> 
else?? 
{?? 
objResponseJson@@ #
=@@$ %
JsonConvert@@& 1
.@@1 2
SerializeObject@@2 A
(@@A B
new@@B E
{@@F G
Message@@H O
=@@O P#
DocumentServiceMessages@@P g
.@@g h
UploadFailed@@h t
,@@t u
Status@@u {
=@@| }
false	@@~ Г
}
@@Г Д
)
@@Д Е
;
@@Е Ж
returnAA 
OkAA 
(AA 
objResponseJsonAA -
)AA- .
;AA. /
}BB 
}CC 
catchDD 
(DD 
	ExceptionDD 
exDD 
)DD  
{EE 
DebugFF 
.FF 
	WriteLineFF 
(FF  
exFF  "
.FF" #
MessageFF# *
)FF* +
;FF+ ,
objResponseJsonGG 
=GG  !
JsonConvertGG" -
.GG- .
SerializeObjectGG. =
(GG= >
newGG> A
{GGB C
MessageGGD K
=GGL M#
DocumentServiceMessagesGGN e
.GGe f
ExceptionOccuredGGf v
,GGv w
StatusGGw }
=GG~ 
false
GGА Е
}
GGЕ Ж
)
GGЖ З
;
GGЗ И
}HH 
returnII 
OkII 
(II 
objResponseJsonII %
)II% &
;II& '
}JJ 	
[MM 	
HttpGetMM	 
]MM 
[NN 	
RouteNN	 
(NN 
$strNN  
)NN  !
]NN! "
publicOO 
asyncOO 
TaskOO 
<OO 
IActionResultOO '
>OO' ((
SearchItemsFromDynamoDbAsyncOO) E
(OOE F
)OOF G
{PP 	
tryQQ 
{RR 
varSS 
itemsSS 
=SS 
awaitSS !
_clientServiceSS" 0
.SS0 1(
SearchItemsFromDynamoDbAsyncSS1 M
(SSM N
)SSN O
;SSO P
returnTT 
OkTT 
(TT 
itemsTT 
)TT  
;TT  !
}UU 
catchVV 
(VV 
	ExceptionVV 
exVV 
)VV  
{WW 
DebugXX 
.XX 
	WriteLineXX 
(XX  
exXX  "
.XX" #
MessageXX# *
)XX* +
;XX+ ,
returnYY 

BadRequestYY !
(YY! "
)YY" #
;YY# $
}ZZ 
}\\ 	
private__ 
async__ 
Task__ 
<__ 
bool__ 
>__  
UploadFileToS3__! /
(__/ 0
	IFormFile__0 9
file__: >
)__> ?
{`` 	
tryaa 
{bb 
varcc 
fileNamecc 
=cc )
ContentDispositionHeaderValuecc <
.cc< =
Parsecc= B
(ccB C
fileccC G
.ccG H
ContentDispositionccH Z
)ccZ [
.cc[ \
FileNamecc\ d
!ccd e
.cce f
Trimccf j
(ccj k
$charcck n
)ccn o
;cco p
varee 
streamee 
=ee 
fileee !
.ee! "
OpenReadStreamee" 0
(ee0 1
)ee1 2
;ee2 3
varff 
uploadResponseff "
=ff# $
awaitff% *
_clientServiceff+ 9
.ff9 :
UploadFileAsyncff: I
(ffI J
streamffJ P
,ffP Q
fileNameffR Z
)ffZ [
;ff[ \
returngg 
uploadResponsegg %
;gg% &
}hh 
catchii 
(ii 
	Exceptionii 
)ii 
{jj 
throwkk 
;kk 
}ll 
}mm 	
privatepp 
boolpp 
CheckFileNameExistpp '
(pp' (
stringpp( .
filepp/ 3
)pp3 4
{qq 	
tryrr 
{ss 
vartt 
fileNameExisttt !
=tt" #
_clientServicett$ 2
.tt2 3
IsFileExistAsynctt3 C
(ttC D
filettD H
)ttH I
.ttI J
ResultttJ P
;ttP Q
ifuu 
(uu 
fileNameExistuu !
)uu! "
returnvv 
truevv 
;vv  
elseww 
returnxx 
falsexx  
;xx  !
}yy 
catchzz 
(zz 
	Exceptionzz 
exzz 
)zz  
{{{ 
Debug|| 
.|| 
	WriteLine|| 
(||  
ex||  "
.||" #
Message||# *
)||* +
;||+ ,
throw}} 
;}} 
}~~ 
} 	
}
ГГ 
}ДД ╛

_D:\DocumentService\Technothon\Techonothon-API\DocumentServiceAPI\Interface\IAwsClientService.cs
	namespace 	
DocumentServiceAPI
 
. 
	Interface &
{ 
public		 

	interface		 
IAwsClientService		 &
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
} ∙
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
} ┬
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
} и
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
IAwsClientService ,
,, -
AwsClientService. >
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
. 
WithOrigins &
(& '
$str' >
)> ?
)? @
;@ A
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
Ве
\D:\DocumentService\Technothon\Techonothon-API\DocumentServiceAPI\Service\AwsClientService.cs
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
AwsClientService !
:" #
IAwsClientService$ 5
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
AwsContantsI T
.T U
	AccessKeyU ^
,^ _
AwsContants 
. 
	SecretKey !
,! "
Amazon 
. 
RegionEndpoint !
.! "
USEast1" )
)) *
;* +
private 
static 
readonly  
AmazonDynamoDBClient  4
_dynamoDBClient5 D
=E F
newG J 
AmazonDynamoDBClientK _
(_ `
AwsContants` k
.k l
	AccessKeyl u
,u v
AwsContants 
. 
	SecretKey !
,! "
Amazon 
. 
RegionEndpoint !
.! "
USEast1" )
)) *
;* +
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
AwsContants! ,
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
; 
await   
	_s3Client   
.    
PutObjectAsync    .
(  . /

putRequest  / 9
)  9 :
;  : ;
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
AwsContants00! ,
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
InvariantCulture	CCs Г
)
CCГ Д
;
CCД Е
varEE 

putRequestEE 
=EE  
newEE! $
PutItemRequestEE% 3
{FF 
	TableNameGG 
=GG 
AwsContantsGG  +
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
$str	KK Б
:
KKБ В!
uploadDocumentModel
KKГ Ц
.
KKЦ Ч
ClientId
KKЧ Я
}
KKЯ а
}
KKб в
,
KKв г
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
StatementDescription	MMy Н
==
MMН П
null
MMП У
?
MMУ Ф
$str
MMХ Ч
:
MMЧ Ш!
uploadDocumentModel
MMШ л
.
MMл м"
StatementDescription
MMм └
}
MM┴ ┬
}
MM├ ─
,
MM─ ┼
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
;QQ 
awaitRR 
_dynamoDBClientRR %
.RR% &
PutItemAsyncRR& 2
(RR2 3

putRequestRR3 =
)RR= >
;RR> ?
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
AwsContantscc  +
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
AwsContants||  +
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
АА 
ApplicationId
ББ !
=
ББ" #
i
ББ$ %
[
ББ% &
nameof
ББ& ,
(
ББ, -
GetDocumentModel
ББ- =
.
ББ= >
ApplicationId
ББ> K
)
ББK L
]
ББL M
.
ББM N
S
ББN O
,
ББO P
ClientId
ВВ 
=
ВВ 
i
ВВ  
[
ВВ  !
nameof
ВВ! '
(
ВВ' (
GetDocumentModel
ВВ( 8
.
ВВ8 9
ClientId
ВВ9 A
)
ВВA B
]
ВВB C
.
ВВC D
S
ВВD E
,
ВВE F
File
ГГ 
=
ГГ 
i
ГГ 
[
ГГ 
nameof
ГГ #
(
ГГ# $
GetDocumentModel
ГГ$ 4
.
ГГ4 5
File
ГГ5 9
)
ГГ9 :
]
ГГ: ;
.
ГГ; <
S
ГГ< =
,
ГГ= >"
StatementDescription
ДД (
=
ДД) *
i
ДД+ ,
[
ДД, -
nameof
ДД- 3
(
ДД3 4
GetDocumentModel
ДД4 D
.
ДДD E"
StatementDescription
ДДE Y
)
ДДY Z
]
ДДZ [
.
ДД[ \
S
ДД\ ]
,
ДД] ^
FileURL
ЕЕ 
=
ЕЕ 
GetPreSignedUrl
ЕЕ -
(
ЕЕ- .
i
ЕЕ. /
[
ЕЕ/ 0
nameof
ЕЕ0 6
(
ЕЕ6 7
GetDocumentModel
ЕЕ7 G
.
ЕЕG H
File
ЕЕH L
)
ЕЕL M
]
ЕЕM N
.
ЕЕN O
S
ЕЕO P
)
ЕЕP Q
,
ЕЕQ R
CreationDate
ЖЖ  
=
ЖЖ! "
i
ЖЖ# $
[
ЖЖ$ %
nameof
ЖЖ% +
(
ЖЖ+ ,
GetDocumentModel
ЖЖ, <
.
ЖЖ< =
CreationDate
ЖЖ= I
)
ЖЖI J
]
ЖЖJ K
.
ЖЖK L
S
ЖЖL M
,
ЖЖM N"
FormatedCreationDate
ЗЗ (
=
ЗЗ) *
DateTime
ЗЗ+ 3
.
ЗЗ3 4

ParseExact
ЗЗ4 >
(
ЗЗ> ?
i
ЗЗ? @
[
ЗЗ@ A
nameof
ЗЗA G
(
ЗЗG H
GetDocumentModel
ЗЗH X
.
ЗЗX Y
CreationDate
ЗЗY e
)
ЗЗe f
]
ЗЗf g
.
ЗЗg h
S
ЗЗh i
,
ЗЗi j
$str
ЗЗj 
,ЗЗ А
SystemЗЗА Ж
.ЗЗЖ З
GlobalizationЗЗЗ Ф
.ЗЗФ Х
CultureInfoЗЗХ а
.ЗЗа б 
InvariantCultureЗЗб ▒
)ЗЗ▒ ▓
.ЗЗ▓ │
ToStringЗЗ│ ╗
(ЗЗ╗ ╝
$strЗЗ╝ ╚
,ЗЗ╚ ╔
SystemЗЗ╔ ╧
.ЗЗ╧ ╨
GlobalizationЗЗ╨ ▌
.ЗЗ▌ ▐
CultureInfoЗЗ▐ щ
.ЗЗщ ъ 
InvariantCultureЗЗъ ·
)ЗЗ· √
}
ИИ 
)
ИИ 
.
ИИ 
OrderBy
ИИ 
(
ИИ 
x
ИИ 
=>
ИИ 
DateTime
ИИ  (
.
ИИ( )

ParseExact
ИИ) 3
(
ИИ3 4
x
ИИ4 5
.
ИИ5 6
CreationDate
ИИ6 B
!
ИИB C
,
ИИC D
$str
ИИD Y
,
ИИY Z
System
ИИZ `
.
ИИ` a
Globalization
ИИa n
.
ИИn o
CultureInfo
ИИo z
.
ИИz {
InvariantCultureИИ{ Л
)ИИЛ М
)ИИМ Н
.
ЙЙ 
ToList
ЙЙ 
(
ЙЙ 
)
ЙЙ 
;
ЙЙ 
return
ЛЛ 
getDocumentsModel
ЛЛ (
;
ЛЛ( )
}
ММ 
catch
НН 
(
НН 
	Exception
НН 
)
НН 
{
ОО 
throw
ПП 
;
ПП 
}
РР 
}
СС 	
public
ФФ 
async
ФФ 
Task
ФФ 
<
ФФ 
bool
ФФ 
>
ФФ '
IsApplicationIdExistAsync
ФФ  9
(
ФФ9 :
string
ФФ: @
applicationId
ФФA N
)
ФФN O
{
ХХ 	
try
ЦЦ 
{
ЧЧ 
var
ШШ 
request
ШШ 
=
ШШ 
new
ШШ !
ScanRequest
ШШ" -
{
ЩЩ 
	TableName
ЪЪ 
=
ЪЪ 
AwsContants
ЪЪ  +
.
ЪЪ+ ,
DynamoDbTableName
ЪЪ, =
}
ЫЫ 
;
ЫЫ 
var
ЬЬ 
response
ЬЬ 
=
ЬЬ 
await
ЬЬ $
_dynamoDBClient
ЬЬ% 4
.
ЬЬ4 5
	ScanAsync
ЬЬ5 >
(
ЬЬ> ?
request
ЬЬ? F
)
ЬЬF G
;
ЬЬG H
if
ЭЭ 
(
ЭЭ 
response
ЭЭ 
.
ЭЭ 
Items
ЭЭ !
.
ЭЭ! "
ToList
ЭЭ" (
(
ЭЭ( )
)
ЭЭ) *
.
ЭЭ* +
Count
ЭЭ+ 0
==
ЭЭ2 4
$num
ЭЭ5 6
)
ЭЭ6 7
{
ЮЮ 
return
ЯЯ 
false
ЯЯ  
;
ЯЯ  !
}
аа 
var
бб 
getDocumentModels
бб %
=
бб& '
response
бб( 0
.
бб0 1
Items
бб1 6
.
бб6 7
Select
бб7 =
(
бб= >
i
бб> ?
=>
бб@ B
new
ббC F
GetDocumentModel
ббG W
{
вв 
ApplicationId
гг !
=
гг" #
i
гг$ %
[
гг% &
nameof
гг& ,
(
гг, -
ApplicationId
гг- :
)
гг: ;
]
гг; <
.
гг< =
S
гг= >
}
дд 
)
дд 
.
дд 
ToList
дд 
(
дд 
)
дд 
;
дд 
var
жж 
checkItemExist
жж "
=
жж# $
getDocumentModels
жж% 6
.
жж6 7
Any
жж7 :
(
жж: ;
x
жж; <
=>
жж= ?
x
жж@ A
.
жжA B
ApplicationId
жжB O
==
жжP R
applicationId
жжS `
)
жж` a
;
жжa b
return
зз 
checkItemExist
зз %
;
зз% &
}
ии 
catch
йй 
(
йй 
	Exception
йй 
)
йй 
{
кк 
throw
лл 
;
лл 
}
мм 
}
нн 	
public
░░ 
async
░░ 
Task
░░ 
<
░░ 
bool
░░ 
>
░░ 
IsFileExistAsync
░░  0
(
░░0 1
string
░░1 7
file
░░8 <
)
░░< =
{
▒▒ 	
try
▓▓ 
{
││ 
var
┤┤ 
request
┤┤ 
=
┤┤ 
new
┤┤ !
ScanRequest
┤┤" -
{
╡╡ 
	TableName
╢╢ 
=
╢╢ 
AwsContants
╢╢  +
.
╢╢+ ,
DynamoDbTableName
╢╢, =
}
╖╖ 
;
╖╖ 
var
╕╕ 
response
╕╕ 
=
╕╕ 
await
╕╕ $
_dynamoDBClient
╕╕% 4
.
╕╕4 5
	ScanAsync
╕╕5 >
(
╕╕> ?
request
╕╕? F
)
╕╕F G
;
╕╕G H
if
╣╣ 
(
╣╣ 
response
╣╣ 
.
╣╣ 
Items
╣╣ !
.
╣╣! "
ToList
╣╣" (
(
╣╣( )
)
╣╣) *
.
╣╣* +
Count
╣╣+ 0
==
╣╣2 4
$num
╣╣5 6
)
╣╣6 7
{
║║ 
return
╗╗ 
false
╗╗  
;
╗╗  !
}
╝╝ 
var
╜╜ 
getDocumentModels
╜╜ %
=
╜╜& '
response
╜╜( 0
.
╜╜0 1
Items
╜╜1 6
.
╜╜6 7
Select
╜╜7 =
(
╜╜= >
i
╜╜> ?
=>
╜╜@ B
new
╜╜C F
GetDocumentModel
╜╜G W
{
╛╛ 
File
┐┐ 
=
┐┐ 
i
┐┐ 
[
┐┐ 
nameof
┐┐ #
(
┐┐# $
File
┐┐$ (
)
┐┐( )
]
┐┐) *
.
┐┐* +
S
┐┐+ ,
}
└└ 
)
└└ 
.
└└ 
ToList
└└ 
(
└└ 
)
└└ 
;
└└ 
var
┬┬ 
checkItemExist
┬┬ "
=
┬┬# $
getDocumentModels
┬┬% 6
.
┬┬6 7
Any
┬┬7 :
(
┬┬: ;
x
┬┬; <
=>
┬┬= ?
x
┬┬@ A
.
┬┬A B
File
┬┬B F
==
┬┬G I
file
┬┬J N
)
┬┬N O
;
┬┬O P
return
├├ 
checkItemExist
├├ %
;
├├% &
}
── 
catch
┼┼ 
(
┼┼ 
	Exception
┼┼ 
)
┼┼ 
{
╞╞ 
throw
╟╟ 
;
╟╟ 
}
╚╚ 
}
╔╔ 	
public
╠╠ 
async
╠╠ 
Task
╠╠ 
<
╠╠ 
bool
╠╠ 
>
╠╠ 
DeleteFileAsync
╠╠  /
(
╠╠/ 0
string
╠╠0 6
fileName
╠╠7 ?
)
╠╠? @
{
══ 	
try
╬╬ 
{
╧╧ 
var
╨╨ 
deleteRequest
╨╨ !
=
╨╨" #
new
╨╨$ '!
DeleteObjectRequest
╨╨( ;
{
╤╤ 

BucketName
╥╥ 
=
╥╥  
AwsContants
╥╥! ,
.
╥╥, -

BucketName
╥╥- 7
,
╥╥7 8
Key
╙╙ 
=
╙╙ 
fileName
╙╙ "
}
╘╘ 
;
╘╘ 
await
╒╒ 
	_s3Client
╒╒ 
.
╒╒  
DeleteObjectAsync
╒╒  1
(
╒╒1 2
deleteRequest
╒╒2 ?
)
╒╒? @
;
╒╒@ A
return
╓╓ 
true
╓╓ 
;
╓╓ 
}
╫╫ 
catch
╪╪ 
(
╪╪ 
	Exception
╪╪ 
)
╪╪ 
{
┘┘ 
throw
┌┌ 
;
┌┌ 
}
██ 
}
▄▄ 	
private
▀▀ 
string
▀▀ #
GenerateApplicationId
▀▀ ,
(
▀▀, -
)
▀▀- .
{
рр 	
try
сс 
{
тт 
var
уу 
applicationId
уу !
=
уу" #
Guid
уу$ (
.
уу( )
NewGuid
уу) 0
(
уу0 1
)
уу1 2
.
уу2 3
ToString
уу3 ;
(
уу; <
)
уу< =
;
уу= >
bool
фф  
applicationIdExist
фф (
=
фф) *'
IsApplicationIdExistAsync
фф+ D
(
ффD E
applicationId
ффE R
)
ффR S
.
ффS T
Result
ффT Z
;
ффZ [
if
цц 
(
цц  
applicationIdExist
цц %
)
цц% &
return
чч #
GenerateApplicationId
чч 0
(
чч0 1
)
чч1 2
;
чч2 3
else
шш 
return
щщ 
applicationId
щщ (
;
щщ( )
}
ъъ 
catch
ыы 
(
ыы 
	Exception
ыы 
ex
ыы 
)
ыы  
{
ьь 
Debug
ээ 
.
ээ 
	WriteLine
ээ 
(
ээ  
ex
ээ  "
.
ээ" #
Message
ээ# *
)
ээ* +
;
ээ+ ,
throw
юю 
;
юю 
}
яя 
}
ёё 	
}
ЄЄ 
}єє 