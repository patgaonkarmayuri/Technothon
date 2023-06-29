�
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
} �P
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
false	##} �
}
##� �
)
##� �
;
##� �
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
=	'' �
false
''� �
}
''� �
)
''� �
;
''� �
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
false	-- �
}
--� �
)
--� �
;
--� �
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
Status	77z �
=
77� �
true
77� �
}
77� �
)
77� �
;
77� �
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
<<� �
false
<<� �
}
<<� �
)
<<� �
;
<<� �
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
false	@@~ �
}
@@� �
)
@@� �
;
@@� �
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
GG� �
}
GG� �
)
GG� �
;
GG� �
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
�� 
}�� �

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
��
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
AwsContants
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
AwsContants
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
AwsContants
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
�� 
await
�� 
	_s3Client
�� 
.
��  
DeleteObjectAsync
��  1
(
��1 2
deleteRequest
��2 ?
)
��? @
;
��@ A
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