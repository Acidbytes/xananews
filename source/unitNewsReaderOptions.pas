unit unitNewsReaderOptions;

interface

uses Windows, Classes, SysUtils, Forms, Graphics, StrUtils, cmpMessageScrollBox, NewsGlobals, unitExSettings;

type
// nb - these enums must match the 'Items' in the Appearances list view in design mode.
  TAppearanceEnum = (
    apMessageHeaders,
    apMessagesToMe,
    apMessagesFromMe,
    apXanaNewsMessages,
    apDormantMessages,
    apReplies,
    apIgnoredMessages,
    apChildlessMessages,
    apInterestingMessages,
    apMessagePane,
    apHeadersInMessagePane,
    apSignaturesInMessagePane,
    apLevel1Quotes,
    apLevel2Quotes,
    apLevel3Quotes,
    apMessageEditor,
    apSubscribedGroups
  );

  TAppearanceSettings = class
  private
    fFontName : string;
    fFontColor : TColor;
    fFontStyle : TFontStyles;
    fFontSize : Integer;
    fBackgroundColor : TColor;

    procedure Load (reg : TExSettings);
    procedure Save (reg : TExSettings);

  public
    property FontName : string read fFontName write fFontName;
    property FontColor : TColor read fFontColor write fFontColor;
    property FontStyle : TFontStyles read fFontStyle write fFontStyle;
    property FontSize : Integer read fFontSize write fFontSize;
    property BackgroundColor : TColor read fBackgroundColor write fBackgroundColor;

    function ApplyFontAndGetColor (font : TFont; FixedFont : string = '') : TColor;
    procedure Init (font : TFont; bkColor : TColor);

    procedure Assign (source : TAppearanceSettings);
    function Equals (source : TAppearanceSettings) : boolean;
  end;

  TIntArray = array of Integer;
  TViewMode = (vmNormal, vmRawText, vmRaw, vmImages);
  TNewsreaderOptions = class
  private
    fAppKey: string;
    fReg : TExSettings;

    fAppearances : array [TAppearanceEnum] of TAppearanceSettings;
    fAutoDisconnectOnIdle: Boolean;
    fAutoDisconnectOnExit: Boolean;
    fPanelLeft: Integer;
    fArticlesHeight: Integer;
    fArticlesColumnPCs : TIntArray;
    fArticlesColumnPositions : TIntArray;
    fShowHeader : TShowHeader;
    fAutoExpandThread: boolean;
    fHideFolderIcons : boolean;
    fAutoExpandAll: boolean;
    fAutoMarkAsRead: boolean;
    fAutoMarkSeconds : Integer;
    fAutoCentralizeMessage: boolean;
    fQueuedRequestsHeight: Integer;
    fViewMode: TViewMode;
    fTreeColumn : Integer;
    fUnreadFontStyle: TFontStyles;
    fFirstLineAsSubject: boolean;
    fUnreadNewsgroupsFontStyle: TFontStyles;
    fTextWindowSizeK : Integer;
    fShowDetailsBar : boolean;
    fCheckSpelling : boolean;
    fShowInSystemTray: boolean;
    fEnterGetMessages: boolean;
    fEnterGoToNextGroup: boolean;
    fQuoteSelectedText : boolean;
    fGroupsWithMessagesFontStyle: TFontStyles;
    fAutoDownloadOnClick: boolean;
    fKeywordColors : array [0..7] of TColorRef;
    fKeyPhrase : array [0..7] of string;
    fKeyPattern : array [0..7] of string;
    fHideColumnFlags : DWORD;
    fWrapLines : Integer;
    fEnterLoadsMessage: boolean;
    fNoXFaces : boolean;
    fLoaded : boolean;
    fShowCustomHeaders: TStringList;
    fHideReadMessages : boolean;
    fHideIgnoredMessages: boolean;
    fNoHTML: boolean;
    fShowMessageCount : boolean;
    fBookmarkColumnPCs: TIntArray;
    fBookmarkHeight: Integer;
    fAutoExpandGroupTree: boolean;
    fAutoContractGroupTree: boolean;
    fMagicUser: boolean;
    fTrimGroupNames: Integer;
    fPanelLeftHeight: Integer;
    fPanelLeftSplitter: Integer;
    fPanelLeftLeft: Integer;
    fPanelLeftTop: Integer;
    fMainToolbarLeft: Integer;
    fMenuToolbarLeft: Integer;
    fMainToolbarTop: Integer;
    fMenuToolbarTop: Integer;
    fAutoCrosspostDetect: boolean;
    fCheckCrossposts : Integer;
    fDontHighlightXanaNewsUsers: boolean;
    fHighlightSelectedText : boolean;
    fAutoRemoveFromBin: Integer;
    fDeservesMedal: boolean;
    fShowTooltips: boolean;
    fShowInterestingMarkers: Integer;
    fSearchInternetURLStub: string;
    fTextInternetURLStub : string;
    fStrictSigSep: boolean;
    fPlainTextPasswords: boolean;
    fDefaultBozoAction: TBozoAction;
    fAutofitImages : boolean;

    function OpenRegistry (const subKey : string; readOnly : boolean) : boolean;
    procedure CloseRegistry;
    function GetAppearance(idx: TAppearanceEnum): TAppearanceSettings;
    function GetKeywordColors(idx: Integer): TColor;
    procedure SetKeywordColors(idx: Integer; const Value: TColor);
    function GetKeyPhrase(idx: Integer): string;
    procedure SetKeyPhrase(idx: Integer; const Value: string);
    function GetKeyPattern(idx: Integer): string;
    function GetHideColumn(idx: Integer): boolean;
    procedure SetHideColumn(idx: Integer; const Value: boolean);
  public
    constructor Create;
    destructor Destroy; override;
    property AppKey : string read fAppKey write fAppKey;
    procedure Save;
    procedure Load;
    procedure Reload;

    procedure LoadKeyboardShortcuts;
    procedure SaveKeyboardShortcuts;

    property Appearance [idx : TAppearanceEnum] : TAppearanceSettings read GetAppearance;

    property AutoDisconnectOnIdle : Boolean read fAutoDisconnectOnIdle write fAutoDisconnectOnIdle;
    property AutoDisconnectOnExit : Boolean read fAutoDisconnectOnExit write fAutoDisconnectOnExit;
    property AutoExpandThread     : boolean read fAutoExpandThread write fAutoExpandThread;
    property AutoExpandAll        : boolean read fAutoExpandAll write fAutoExpandAll;
    property AutoExpandGroupTree  : boolean read fAutoExpandGroupTree write fAutOExpandGroupTree;
    property AutoContractGroupTree: boolean read fAutoContractGroupTree write fAutoContractGroupTree;
    property StrictSigSep         : boolean read fStrictSigSep write fStrictSigSep;
    property AutofitImages        : boolean read fAutofitImages write fAutofitImages;
    property HideFolderIcons      : boolean read fHideFolderIcons write fHideFolderIcons;
    property AutoCentralizeMessage : boolean read fAutoCentralizeMessage write fAutoCentralizeMessage;
    property AutoMarkAsRead : boolean read fAutoMarkAsRead write fAutoMarkAsRead;
    property AutoMarkSeconds : integer read fAutoMarkSeconds write fAutoMarkSeconds;
    property AutoDownloadOnClick : boolean read fAutoDownloadOnClick write fAutoDownloadOnClick;
    property FirstLineAsSubject : boolean read fFirstLineAsSubject write fFirstLineAsSubject;
    property DontHighlightXanaNewsUsers: boolean read fDontHighlightXanaNewsUsers write fDontHighlightXanaNewsUsers;
    property HighlightSelectedText : boolean read fHighlightSelectedText write fHighlightSelectedText;

    property PanelLeft : Integer read fPanelLeft write fPanelLeft; // Width

    property PanelLeftLeft : Integer read fPanelLeftLeft write fPanelLeftLeft;
    property PanelLeftTop : Integer read fPanelLeftTop write fPanelLeftTop;
    property PanelLeftHeight : Integer read fPanelLeftHeight write fPanelLeftHeight;

    property MainToolbarLeft : Integer read fMainToolbarLeft write fMainToolbarLeft;
    property MenuToolbarLeft : Integer read fMenuToolbarLeft write fMenuToolbarLeft;
    property MainToolbarTop : Integer read fMainToolbarTop write fMainToolbarTop;
    property MenuToolbarTop : Integer read fMenuToolbarTop write fMenuToolbarTop;

    property PanelLeftSplitter : Integer read fPanelLeftSplitter write fPanelLeftSplitter;

    property ArticlesHeight : Integer read fArticlesHeight write fArticlesHeight;
    property BookmarkHeight : Integer read fBookmarkHeight write fBookmarkHeight;
    property QueuedRequestsHeight : Integer read fQueuedRequestsHeight write fQueuedRequestsHeight;
    property ArticlesColumnPCs: TIntArray read fArticlesColumnPCs;
    property BookmarkColumnPCs: TIntArray read fBookmarkColumnPCs;
    property ArticlesColumnPositions: TIntArray read fArticlesColumnPositions;
    property ShowHeader : TShowHeader read fShowHeader Write fShowHeader;
    property ViewMode : TViewMode read fViewMode write fViewMode;
    property TextWindowSizeK : Integer read fTextWindowSizeK write fTextWindowSizeK;

    property TreeColumn : Integer read fTreeColumn write fTreeColumn;
    property UnreadFontStyle : TFontStyles read fUnreadFontStyle write fUnreadFontStyle;
    property UnreadNewsgroupsFontStyle : TFontStyles read fUnreadNewsgroupsFontStyle write fUnreadNewsgroupsFontStyle;
    property GroupsWithMessagesFontStyle : TFontStyles read fGroupsWithMessagesFontStyle write fGroupsWithMessagesFontStyle;

    property AutoCrosspostDetect : boolean read fAutoCrosspostDetect write fAutoCrosspostDetect;
    property ShowTooltips : boolean read fShowTooltips write fShowTooltips;
    property CheckCrossposts : Integer read fCheckCrossposts write fCheckCrossposts;
    property AutoRemoveFromBin : Integer read fAutoRemoveFromBin write fAutOremoveFromBin;
    property ShowInSystemTray : boolean read fShowInSystemTray write fShowInSystemTray;
    property ShowDetailsBar : boolean read fShowDetailsBar write fShowDetailsBar;
    property CheckSpelling : boolean read fCheckSpelling write fCheckSpelling;
    property SearchInternetURLStub : string read fSearchInternetURLStub write fSearchInternetURLStub;
    property TextInternetURLStub : string read fTextInternetURLStub write fTextInternetURLStub;

    property EnterGoToNextGroup : boolean read fEnterGoToNextGroup write fEnterGoToNextGroup;
    property EnterGetMessages : boolean read fEnterGetMessages write fEnterGetMessages;
    property ShowMessageCount : boolean read fShowMessageCount write fShowMessageCount;
    property EnterLoadsMessage : boolean read fEnterLoadsMessage write fEnterLoadsMessage;
    property ShowInterestingMarkers : Integer read fShowInterestingMarkers write fShowInterestingMarkers;

    property QuoteSelectedText : boolean read fQuoteSelectedText write fQuoteSelectedText;
    property KeywordColors [idx : Integer] : TColor read GetKeywordColors write SetKeywordColors;
    property KeyPhrase [idx : Integer] : string read GetKeyPhrase write SetKeyPhrase;
    property KeyPattern [idx : Integer] : string read GetKeyPattern;
    property HideColumn [idx : Integer] : boolean read GetHideColumn write SetHideColumn;

    property WrapLines : Integer read fWrapLines write fWrapLines;
    property NoXFaces : boolean read fNoXFaces write fNoXFaces;
    property NoHTML : boolean read fNoHTML write fNoHTML;

    property HideReadMessages : boolean read fHideReadMessages write fHidereadMessages;
    property HideIgnoredMessages : boolean read fHideIgnoredMessages write fHideIgnoredMessages;

    property ShowCustomHeaders : TStringList read fShowCustomHeaders;

    property MagicUser : boolean read fMagicUser;
    property TrimGroupNames : Integer read fTrimGroupNames write fTrimGroupNames;
    property DeservesMedal : boolean read fDeservesMedal write fDeservesMedal;
    property PlainTextPasswords : boolean read fPlainTextPasswords write fPlainTextPasswords;
    property DefaultBozoAction : TBozoAction read fDefaultBozoAction write fDefaultBozoAction;
  end;

var
  Options : TNewsreaderOptions = Nil;
  gDefaultWindowSizeK : Integer;


implementation

uses unitSearchString, unitNNTPServices;

const
  AppearanceKeyNames : array [TAppearanceEnum] of string = (
    'Articles Tree',
    'Messages To Me',
    'My Messages',
    'XanaNews Messages',
    'Dormant Messages',
    'Replies to my Messages',
    'Ignored Messages',
    'Messages Without Replies',
    'Interesting Messages',
    'Article',
    'Message Pane Headers',
    'Message Pane Signatures',
    'Message Pane Level1 Quotes',
    'Message Pane Level2 Quotes',
    'Message Pane Level3 Quotes',
    'Message Editor',
    'Newsgroup Tree');

  AppearancesFontColorDefaults : array [TAppearanceEnum] of TColor = (
    clBlack,            // Articles Tree
    clBlue,             // Messages to Me
    clLime,             // My Messages
    clGreen,            // Xananews Messages
    clGray,             // Dormant Messages
    clFuchsia,          // Replies
    clYellow,           // Ignored
    clBlack,            // Childless
    clBlack,            // Interesting
    clBlack,            // Articles
    clGray,             // Message pane headers
    clGray,
    clTeal,
    clOlive,
    clPurple,
    clBlack,
    clBlack);

  ShowCustomHeadersDefault = 'From:1,Subject:1,Date:0,Message-Id:0,Lines:0,Path:0,Newsgroups:0,Organization:0,NNTP-Posting-Host:0,User-Agent:1,XRef:0,MIME-Version:0,Content-Type:0,X-Trace:0,X-Complaints-To:0';

{ TNewsreaderOptions }

function CountChar (const st : string; ch : char) : Integer;
var
  i : Integer;
begin
  Result := 0;
  for i := 1 to Length (st) do
    if st [i] = ch then
      Inc (Result)
end;


procedure TNewsreaderOptions.CloseRegistry;
begin
  FreeAndNil (fReg);
end;

constructor TNewsreaderOptions.Create;
var
  i : TAppearanceEnum;
  n : Integer;
begin
  fShowCustomHeaders := TStringList.Create;
  fShowCustomHeaders.CaseSensitive := False;
  fShowCustomHeaders.NameValueSeparator := ':';
  fShowCustomHeaders.CommaText := ShowCustomHeadersDefault;
  fAutoDisconnectOnIdle := False;
  fAutoDisconnectOnExit := True;
  fAutoCentralizeMessage := True;
  fAutofitImages := True;
  fHideFolderIcons := True;
  fShowTooltips := True;
  fPlainTextPasswords := False;
  fDefaultBozoAction := baIgnore;
  fShowDetailsBar := True;
  fCheckSpelling := True;
  fAutoExpandThread := True;
  fQuoteSelectedText := True;
  fEnterLoadsMessage := True;
  fTextWindowSizeK := gDefaultWindowSizeK;
  fCheckCrossposts := 3;
  fAutoRemoveFromBin := 30;
  fSearchInternetURLStub := 'http://groups-beta.google.com/groups?threadm=%qid%';
  fTextInternetURLStub := 'http://www.google.com/search?hl=en&q="%qtext%"';

  for i := Low (TAppearanceEnum) to High (TAppearanceEnum) do
    fAppearances [i] := TAppearanceSettings.Create;

  fShowHeader := shShort;
  SetLength (fArticlesColumnPCs, 5);
  SetLength (fBookmarkColumnPCs, 5);
  SetLength (fArticlesColumnPositions, 6);
  fTreeColumn := 2;
  fFirstLineAsSubject := True;
  fUnreadFontStyle := [fsBold];
  fUnreadnewsgroupsFontStyle := [fsBold];
  fGroupsWithMessagesFontStyle := [fsBold];
  fEnterGetMessages := True;
  fShowMessageCount := True;
  fEnterGoToNextGroup := True;
  fAutoMarkAsRead := True;

  fKeywordColors [0] := clRed;
  fKeywordColors [1] := clLime;
  fKeywordColors [2] := clYellow;
  fKeywordColors [3] := clBlue;
  fKeywordColors [4] := clFuchsia;
  fKeywordColors [5] := clAqua;
  fKeywordColors [6] := clOlive;
  fKeywordColors [7] := clMaroon;

  for n := 0 to 7 do
    fKeyPattern [n] := '~';

  fAppKey := 'Software\Woozle\XanaNews';

end;

destructor TNewsreaderOptions.Destroy;
var
  i : TAppearanceEnum;
begin
  for i := Low (TAppearanceEnum) to High (TAppearanceEnum) do
    fAppearances [i].Free;

  fShowCustomHeaders.Free;
  CloseRegistry;

  inherited;
end;

procedure TNewsreaderOptions.Load;
var
  w : Integer;
  st, s : string;
  i : TAppearanceEnum;
begin
  if fLoaded then Exit;
  fArticlesColumnPCs [0] := 5;    // Flags
  fArticlesColumnPCs [1] := 10;   // Number
  fArticlesColumnPCs [2] := 45;   // Subject
  fArticlesColumnPCs [3] := 20;   // Author
  fArticlesColumnPCs [4] := 10;   // Date
                                  // remainder = lines

  fBookmarkColumnPCs [0] := 25;   // Account/Group
  fBookmarkColumnPCs [1] := 23;   // Subject
  fBookmarkColumnPCs [2] := 25;   // From
  fBookmarkColumnPCs [3] := 10;   // Date
  fBookmarkColumnPCs [4] := 7;   // Lines
                                  // remainder = bookmarked Date
  fArticlesColumnPositions [0] := 0;
  fArticlesColumnPositions [1] := 1;
  fArticlesColumnPositions [2] := 2;
  fArticlesColumnPositions [3] := 3;
  fArticlesColumnPositions [4] := 4;
  fArticlesColumnPositions [5] := 5;

  try
    if OpenRegistry ('General', true) then
    begin
      fShowInSystemTray   := fReg.GetBooleanValue ('Show In System Tray', fShowInSystemTray);
      fSearchInternetURLStub := fReg.GetStringValue ('Search Internet URL Stub', fSearchInternetURLStub);
      fTextInternetURLStub := fReg.GetStringValue ('Text Internet URL Stub', fTextInternetURLStub);
      fAutoCrosspostDetect:= fReg.GetBooleanValue ('Auto Crosspost Detect', fAutoCrosspostDetect);
      fShowTooltips       := fReg.GetBooleanValue ('Show Tooltips', fShowTooltips);
      fPlainTextPasswords := fReg.GetBooleanValue ('Plain Text Passwords', fPlainTextPasswords);
      fDefaultBozoAction := TBozoAction (fReg.GetIntegerValue ('Default Bozo Action', Integer (fDefaultBozoAction)));
      fCheckCrossposts    := fReg.GetIntegerValue ('Check Crossposts', fCheckCrossposts);
      fAutoRemoveFromBin  := fReg.GetIntegerValue ('Auto Remove From Bin', fAutoRemoveFromBin);
      fQuoteSelectedText  := fReg.GetBooleanValue ('Quote Selected Text', fQuoteSelectedText);
      fEnterGetMessages   := fReg.GetBooleanValue ('Enter Gets Messages', fEnterGetMessages);
      fShowMessageCount   := fReg.GetBooleanValue ('Show Message Count', fShowMessageCount);
      fEnterGoToNextGroup := fReg.GetBooleanValue ('Enter Goto Next Group', fEnterGoToNextGroup);
      fEnterLoadsMessage  := fReg.GetBooleanValue ('Enter Loads Message', fEnterLoadsMessage);
      fAutoExpandGroupTree:= fReg.GetBooleanValue ('Auto Expand Group Tree', fAutoExpandGroupTree);
      fAutoContractGroupTree:= fReg.GetBooleanValue ('Auto Contract Group Tree', fAutoContractGroupTree);
      fStrictSigSep := fReg.GetBooleanValue ('Strict Signature Separator', fStrictSigSep);
      fAutofitImages := fReg.GetBooleanValue ('Autofit Images', fAutofitImages);
      fGroupsWithMessagesFontStyle := TFontStyles (Byte (fReg.GetIntegerValue ('Groups With Messages Font Style', Byte (fGroupsWithMessagesFontStyle))));
      fMagicUser:= fReg.GetBooleanValue ('Magic User', False);
      fDeservesMedal := fReg.GetBooleanValue ('Deserves Medal', False);
      fTrimGroupNames := fReg.GetIntegerValue('Trim Group Names', fTrimGroupNames);
      fShowInterestingMarkers := fReg.GetIntegerValue('Show Interesting Markers', fShowInterestingMarkers);

      for w := 0 to 7 do
      begin
        fKeywordColors [w] := fReg.GetIntegerValue ('Keyword Color ' + IntToStr (w), fKeywordColors [w]);
        fKeyphrase [w] := fReg.GetStringValue ('Keyphrase ' + IntToStr (w), '')
      end
    end;

    if OpenRegistry ('Position', true) then
    begin
      fPanelLeft            := fReg.GetIntegerValue ('Panel Left', fPanelLeft);
      fPanelLeftSplitter    := fReg.GetIntegerValue ('Panel Left Splitter', fPanelLeftSplitter);
      fPanelLeftHeight      := fReg.GetIntegerValue('Panel Left Height', fPanelLeftHeight);
      fPanelLeftTop         := fReg.GetIntegerValue('Panel Left Top', fPanelLeftTop);
      fPanelLeftLeft        := fReg.GetIntegerValue('Panel Left Left', fPanelLeftLeft);
      fMenuToolbarLeft      := fReg.GetIntegerValue('Menu Bar Left', fMenuToolbarLeft);
      fMenuToolbarTop      := fReg.GetIntegerValue('Menu Bar Top', fMenuToolbarTop);
      fMainToolbarLeft      := fReg.GetIntegerValue('Main Bar Left', fMainToolbarLeft);
      fMainToolbarTop      := fReg.GetIntegerValue('Main Bar Top', fMainToolbarTop);
      fArticlesHeight       := fReg.GetIntegerValue ('Articles Height', fArticlesHeight);
      fBookmarkHeight       := fReg.GetIntegerValue ('Bookmark Height', fBookmarkHeight);
      fShowHeader           := TShowHeader (fReg.GetIntegerValue ('Show Header', Integer (fShowHeader)));
      fQueuedRequestsHeight := fReg.GetIntegerValue ('Queued Requests Height', fQueuedRequestsHeight);

      if fArticlesHeight = 0 then
        fArticlesHeight := 1;

      if fPanelLeft = 0 then
        fPanelLeft := 1;

      if fBookmarkHeight = 0 then
        fBookmarkHeight := 1;

      if fQueuedRequestsHeight = 0 then
        fQueuedRequestsHeight := 1;

      st := fReg.GetStringValue ('Articles Column PCs', '');

      w := 0;
      repeat
        s := SplitString (',', st);
        if s <> '' then
        begin
          fArticlesColumnPCs [w] := StrToInt (s);
          Inc (w)
        end
      until s = '';

      st := fReg.GetStringValue ('Articles Column Positions', '');

      w := 0;
      repeat
        s := SplitString (',', st);
        if s <> '' then
        begin
          fArticlesColumnPositions [w] := StrToInt (s);
          Inc (w)
        end
      until s = '';

    end;

    for i := Low (TAppearanceEnum) to High (TAppearanceEnum) do
    case i of
      apMessageHeaders,
      apMessagePane,
      apMessageEditor,
      apSubscribedGroups : if OpenRegistry ('Appearance\' + AppearanceKeyNames [i], true) then
                             fAppearances [i].Load(fReg);

      Succ (apMessageHeaders)..
      Pred (apMessagePane) : if OpenRegistry ('Appearance\' + AppearanceKeyNames [i], true) then
                               fAppearances [i].Load(fReg)
                             else
                             begin
                               fAppearances [i].Assign(fAppearances [apMessageHeaders]);
                               fAppearances [i].fFontColor := AppearancesFontColorDefaults [i]
                             end;

      Succ (apMessagePane) ..
      Pred (apMessageEditor) : if OpenRegistry ('Appearance\' + AppearanceKeyNames [i], true) then
                                 fAppearances [i].Load(fReg)
                               else
                               begin
                                 fAppearances [i].Assign(fAppearances [apMessagePane]);
                                 fAppearances [i].fFontColor := AppearancesFontColorDefaults [i]
                               end
    end;

    if OpenRegistry ('Connection', true) then
    begin
      fAutoDisconnectOnIdle  := fReg.GetBooleanValue ('Auto Disconnect On Idle', fAutoDisconnectOnIdle);
      fAutoDisconnectOnExit  := fReg.GetBooleanValue ('Auto Disconnect On Exit', fAutoDisconnectOnExit)
    end;

    if OpenRegistry ('Message Tree', true) then
    begin
      fAutoExpandThread          := fReg.GetBooleanValue ('Auto Expand Thread', fAutoExpandThread);
      fAutoExpandAll             := fReg.GetBooleanValue ('Auto Expand All',    fAutoExpandAll);
      fHideFolderIcons           := fReg.GetBooleanValue ('Hide Folder Icons',  fHideFolderIcons);
      fAutoCentralizeMessage     := fReg.GetBooleanValue ('Auto Centralize Message', fAutoCentralizeMessage);
      fAutoMarkAsRead            := fReg.GetBooleanValue ('Auto Mark As Read', fAutoMarkAsRead);
      fAutoMarkSeconds           := fReg.GetIntegerValue ('Auto Mark Seconds', 0);
      fAutoDownloadOnClick       := fReg.GetBooleanValue ('Auto Download On Click', fAutoDownloadOnClick);
      fFirstLineAsSubject        := fReg.GetBooleanValue ('First Line As Subject', fFirstLineAsSubject);
      fDontHighlightXanaNewsUsers:= fReg.GetBooleanValue ('Dont Highlight Xananews Users', fDontHighlightXanaNewsUsers);
      fHighlightSelectedText     := fReg.GetBooleanValue ('Highlight Selected Text', fHighlightSelectedText);
      fTreeColumn                := fReg.GetIntegerValue ('Tree Column', fTreeColumn);
      fUnreadFontStyle           := TFontStyles (Byte (fReg.GetIntegerValue ('Unread Font Style', Byte (fUnreadFontStyle))));
      fUnreadNewsgroupsFontStyle := TFontStyles (Byte (fReg.GetIntegerValue ('Unread Newsgroups Font Style', Byte (fUnreadNewsgroupsFontStyle))));
      fHideColumnFlags           := fReg.GetIntegerValue ('Hide Column Flags', 0);
      fHideReadMessages          := fReg.GetBooleanValue('Hide Read Messages', fHideReadMessages);
      fHideIgnoredMessages       := fReg.GetBooleanValue('Hide Ignored Messages', fHideIgnoredMessages)
    end;
    if OpenRegistry ('Message Pane', true) then
    begin
      fTextWindowSizeK := fReg.GetIntegerValue ('Text Window Size K', fTextWindowSizeK);
      fShowDetailsBar := fReg.GetBooleanValue ('Show Details Bar', fShowDetailsBar);
      fCheckSpelling := fReg.GetBooleanValue ('Check Spelling', fCheckSpelling);
      fWrapLines := fReg.GetIntegerValue ('Wrap Lines', fWrapLines);
      fNoXFaces := fReg.GetBooleanValue ('No XFaces', fNoXFaces);
      fNoHTML := fReg.GetBooleanValue ('No HTML', fNoHTML);
      fShowCustomHeaders.CommaText := fReg.GetStringValue ('Show Custom Headers', ShowCustomHeadersDefault);
    end;

    fLoaded := True;
  finally
    CloseRegistry
  end;
end;

function TNewsreaderOptions.OpenRegistry(const subKey : string; readOnly : boolean) : boolean;
begin
  if fReg = Nil then
    fReg := CreateExSettings;

  if readOnly then
  begin
    fReg.Section := '';
    result := fReg.HasSection(subKey);
  end
  else
    result := True;

  fReg.Section := subKey;
end;

procedure TNewsreaderOptions.Reload;
begin
  fLoaded := False;
  Load;
end;

procedure TNewsreaderOptions.Save;
var
  i : Integer;
  e : TAppearanceEnum;
  st : string;
  fs : TFontStyles;
  defColor : TColor;
begin
  try
    OpenRegistry ('Position', false);
    fReg.SetIntegerValue ('Panel Left', fPanelLeft, 0);
    fReg.SetIntegerValue ('Panel Left Splitter', fPanelLeftSplitter, 0);
    fReg.SetIntegerValue ('Panel Left Height', fPanelLeftHeight, 0);
    fReg.SetIntegerValue ('Panel Left Left', fPanelLeftLeft, 0);
    fReg.SetIntegerValue ('Panel Left Top', fPanelLeftTop, 0);
    fReg.SetIntegerValue('Menu Bar Left', fMenuToolbarLeft, 9);
    fReg.SetIntegerValue('Menu Bar Top', fMenuToolbarTop, 0);
    fReg.SetIntegerValue('Main Bar Left', fMainToolbarLeft, 9);
    fReg.SetIntegerValue('Main Bar Top', fMainToolbarTop, 23);
    fReg.SetIntegerValue('Articles Height', fArticlesHeight, 0);
    fReg.SetIntegerValue('Bookmark Height', fBookmarkHeight, 0);
    fReg.SetIntegerValue ('Queued Requests Height', fQueuedRequestsHeight, 0);
    fReg.SetIntegerValue ('Show Header', Integer (fShowHeader), Integer (shShort));

    st := '';
    for i := 0 to Length (fArticlesColumnPCs) - 1 do
    begin
      st := st + IntToStr (fArticlesColumnPCs [i]);
      if i < Length (fArticlesColumnPCs) - 1 then
        st := st + ','
    end;
    fReg.SetStringValue('Articles Column PCs', st, '');

    st := '';
    for i := 0 to Length (fArticlesColumnPositions) - 1 do
    begin
      st := st + IntToStr (fArticlesColumnPositions [i]);
      if i < Length (fArticlesColumnPositions) - 1 then
        st := st + ','
    end;
    fReg.SetStringValue('Articles Column Positions', st, '');

    for e := Low (TAppearanceEnum) to High (TAppearanceEnum) do
    begin
      OpenRegistry ('Appearance\' + AppearanceKeyNames [e], false);
      fAppearances [e].Save (fReg)
    end;

    OpenRegistry ('Connection', false);

    fReg.SetBooleanValue('Auto Disconnect On Idle', fAutoDisconnectOnIdle, False);
    fReg.SetBooleanValue('Auto Disconnect On Exit', fAutoDisconnectOnExit, True);

    OpenRegistry ('Message Tree', false);

    fReg.SetBooleanValue ('Auto Expand Thread', fAutoExpandThread, True);
    fReg.SetBooleanValue ('Auto Expand All', fAutoExpandAll, False);
    fReg.SetBooleanValue ('Hide Folder Icons', fHideFolderIcons, True);
    fReg.SetBooleanValue ('Auto Centralize Message', fAutoCentralizeMessage, True);
    fReg.SetBooleanValue ('Auto Mark As Read', fAutoMarkAsRead, True);
    fReg.SetIntegerValue ('Auto Mark Seconds', fAutoMarkSeconds, 0);
    fReg.SetBooleanValue ('Auto Download On Click', fAutoDownloadOnClick, False);
    fReg.SetBooleanValue ('First Line As Subject', fFirstLineAsSubject, True);
    fReg.SetBooleanValue ('Dont Highlight XanaNews Users', fDontHighlightXanaNewsUsers, False);
    fReg.SetBooleanValue ('Highlight Selected Text', fHighlightSelectedText, False);
    fReg.SetIntegerValue ('Tree Column', fTreeColumn, 2);
    fReg.SetIntegerValue ('Hide Column Flags', fHideColumnFlags, 0);
    fs := [fsBold];
    fReg.SetIntegerValue ('Unread Font Style', Byte (fUnreadFontStyle), Byte (fs));
    fReg.SetIntegerValue ('Unread Newsgroups Font Style', Byte (fUnreadNewsgroupsFontStyle), Byte (fs));
    fReg.SetBooleanValue ('Hide Read Messages', fHideReadMessages, False);
    fReg.SetBooleanValue ('Hide Ignored Messages', fHideIgnoredMessages, False);

    OpenRegistry ('Message Pane', false);
    fReg.SetIntegerValue ('Text Window Size K', fTextWindowSizeK, gDefaultWindowSizeK);
    fReg.SetBooleanValue ('Check Spelling', fCheckSpelling, True);
    fReg.SetBooleanValue ('Show Details Bar', fShowDetailsBar, True);
    fReg.SetIntegerValue ('Wrap Lines', fWrapLines, 0);
    fReg.SetBooleanValue ('No XFaces', fNoXfaces, False);
    fReg.SetBooleanValue ('No HTML', fNoHTML, False);
    fReg.SetStringValue ('Show Custom Headers', fShowCustomHeaders.CommaText, ShowCustomHeadersDefault);

    OpenRegistry ('General', false);
    fReg.SetBooleanValue ('Show In System Tray', fShowInSystemTray, False);
    fReg.SetStringValue ('Search Internet URL Stub', fSearchInternetURLStub, '');
    fReg.SetStringValue ('Text Internet URL Stub', fTextInternetURLStub, '');
    fReg.SetBooleanValue ('Auto Crosspost Detect', fAutoCrosspostDetect, False);
    fReg.SetBooleanValue ('Show Tooltips', fShowTooltips, True);
    fReg.SetBooleanValue ('Plain Text Passwords', fPlainTextPasswords, False);
    fReg.SetIntegerValue ('Default Bozo Action', Integer (fDefaultBozoAction), Integer (baIgnore));
    fReg.SetIntegerValue ('Check Crossposts', fCheckCrossposts, 3);
    fReg.SetIntegerValue ('Auto Remove From Bin', fAutoRemoveFromBin, 30);
    fReg.SetBooleanValue ('Quote Selected Text', fQuoteSelectedText, True);
    fReg.SetBooleanValue ('Enter Gets Messages', fEnterGetMessages, True);
    fReg.SetBooleanValue ('Show Message Count', fShowMessageCount, True);
    fReg.SetBooleanValue ('Enter Goto Next Group', fEnterGoToNextGroup, True);
    fReg.SetBooleanValue ('Enter Loads Message', fEnterLoadsMessage, True);
    fReg.SetIntegerValue ('Groups With Messages Font Style', Byte (fGroupsWithMessagesFontStyle), Byte (fs));
    fReg.SetBooleanValue ('Auto Expand Group Tree', fAutoExpandGroupTree, False);
    fReg.SetBooleanValue ('Auto Contract Group Tree', fAutoContractGroupTree, False);
    fReg.SetBooleanValue ('Strict Signature Separator', fStrictSigSep, False);
    fReg.SetIntegerValue ('Trim Group Names', fTrimGroupNames, 0);
    fReg.SetIntegerValue ('Show Interesting Markers', fShowInterestingMarkers, 0);
    fReg.SetBooleanValue ('Deserves Medal', fDeservesMedal, False);
    fReg.SetBooleanValue ('Autofit Images', fAutofitImages, True);

    for i := 0 to 7 do
    begin
      fReg.SetStringValue ('Keyphrase ' + IntToStr (i), fKeyphrase [i], '');
      defColor := clBlack;
      case i of
        0 : defColor := clRed;
        1 : defColor := clLime;
        2 : defColor := clYellow;
        3 : defColor := clBlue;
        4 : defColor := clFuchsia;
        5 : defColor := clAqua;
        6 : defColor := clOlive;
        7 : defColor := clMaroon
      end;

      fReg.SetIntegerValue ('Keyword Color ' + IntToStr (i), fKeywordColors [i], defColor)
    end
  finally
    CloseRegistry
  end;
end;

function TNewsreaderOptions.GetAppearance(
  idx: TAppearanceEnum): TAppearanceSettings;
begin
  result := fAppearances [idx]
end;

function TNewsreaderOptions.GetKeywordColors(idx: Integer): TColor;
begin
  result := fKeywordColors [idx]
end;

procedure TNewsreaderOptions.SetKeywordColors(idx: Integer;
  const Value: TColor);
begin
  fKeywordColors [idx] := Value
end;

function TNewsreaderOptions.GetKeyPhrase(idx: Integer): string;
begin
  result := fKeyPhrase [idx];
end;

procedure TNewsreaderOptions.SetKeyPhrase(idx: Integer;
  const Value: string);
var
  n : Integer;
begin
  if fKeyPhrase [idx] <> Value then
  begin
    fKeyPattern [idx] := '~';
    if fKeyPhrase [idx] = '' then
      n := -1
    else
      n := idx;
    fKeyPhrase [idx] := Value;

    NNTPAccounts.ResetKeyPhraseFlags(n);
  end
end;

function TNewsreaderOptions.GetKeyPattern(idx: Integer): string;
begin
  if fKeyPattern [idx] = '~' then
    fKeyPattern [idx] := fKeyPhrase [idx];

  result := fKeyPattern [idx];
end;

function TNewsreaderOptions.GetHideColumn(idx: Integer): boolean;
begin
  result := (fHideColumnFlags and (1 shl idx)) <> 0
end;

procedure TNewsreaderOptions.SetHideColumn(idx: Integer;
  const Value: boolean);
var
  mask : DWORD;
begin
  mask := 1 shl idx;

  if value then
    fHideColumnFlags := fHideColumnFlags or mask
  else
    fHideColumnFlags := fHideColumnFlags and not mask
end;

procedure TNewsreaderOptions.LoadKeyboardShortcuts;
var
  i : Integer;
  def : TActionDefault;
begin
  if OpenRegistry ('Keyboard Shortcuts', true) then
  try
    for i := 0 to gDefaultActions.Count - 1 do
    begin
      def := TActionDefault (gDefaultActions [i]);

      def.Action.ShortCut := fReg.GetIntegerValue(def.Action.Name, def.Shortcut)
    end
  finally
    CloseRegistry
  end
end;

procedure TNewsreaderOptions.SaveKeyboardShortcuts;
var
  i : Integer;
  def : TActionDefault;
begin
  if OpenRegistry ('Keyboard Shortcuts', false) then
  try
    for i := 0 to gDefaultActions.Count - 1 do
    begin
      def := TActionDefault (gDefaultActions [i]);

      fReg.SetIntegerValue(def.Action.Name, def.Action.ShortCut, def.Shortcut);
    end
  finally
    CloseRegistry
  end
end;

{ TAppearanceSettings }

function TAppearanceSettings.ApplyFontAndGetColor(font: TFont; FixedFont : string = ''): TColor;
begin
  result := BackgroundColor;
  if FixedFont <> '' then
    font.Name := FixedFont
  else
    font.Name := FontName;
  font.Color := FontColor;
  font.Style := FontStyle;
  font.Size := FontSize
end;

procedure TAppearanceSettings.Assign(source: TAppearanceSettings);
begin
  fFontName := source.fFontName;
  fFontColor := source.fFontColor;
  fFontStyle := source.fFontStyle;
  fBackgroundColor := source.fBackgroundColor;
  fFontSize := source.fFontSize
end;

function TAppearanceSettings.Equals(source: TAppearanceSettings): boolean;
begin
  result := (fFontColor = source.fFontColor) and
            (fFontSize = source.fFontSize) and
            (fFontStyle = source.fFontStyle) and
            (fBackgroundColor = source.fBackgroundColor) and
            (fFontName = source.fFontName);
end;

procedure TAppearanceSettings.Init(font: TFont; bkColor: TColor);
begin
  fFontName := font.Name;
  fFontColor := font.Color;
  fFontStyle := font.Style;
  fFontSize := font.Size;
  fBackgroundColor := bkColor
end;

procedure TAppearanceSettings.Load(reg: TExSettings);
begin
  fFontName  := reg.GetStringValue ('Font Name', fFontName);
  fFontColor := reg.GetIntegerValue ('Font Color', fFontColor);
  fFontStyle := TFontStyles (Byte (reg.GetIntegerValue ('Font Style', Byte (fFontStyle))));
  fFontSize  := reg.GetIntegerValue ('Font Size', fFontSize);
  fBackgroundColor := reg.GetIntegerValue('Background Color', fBackgroundColor);
end;

procedure TAppearanceSettings.Save(reg: TExSettings);
begin
  reg.SetStringValue ('Font Name', FontName);
  reg.SetIntegerValue ('Font Color', FontColor);
  reg.SetIntegerValue ('Font Style', Byte (FontStyle));
  reg.SetIntegerValue ('Font Size', FontSize);
  reg.SetIntegerValue ('Background Color', BackgroundColor);
end;

initialization
  if Win32Platform = VER_PLATFORM_WIN32_NT then
    gDefaultWindowSizeK := 1024*1024
  else
    gDefaultWindowSizeK := 8;

  Options := TNewsReaderOptions.Create;
finalization
  FreeAndNil (Options)
end.
