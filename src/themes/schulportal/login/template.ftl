<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
<!DOCTYPE html>
<html class="${properties.kcHtmlClass!}"<#if realm.internationalizationEnabled> lang="${locale.currentLanguageTag}"</#if>>

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    <title>${msg("title")}</title>
    <link rel="icon" href="${url.resourcesPath}/img/ErWIn_Portal_Bildmarke_RGB_Anwendung_HG_Blau.svg" />
    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <style>
        input::-ms-reveal,
        input::-ms-clear {
          display: none;
        }
    </style>
</head>

<body class="${properties.kcBodyClass!}">
    <div class="${properties.kcLoginClass!}">
        <div id="kc-header" class="${properties.kcHeaderClass!}">
            <div id="kc-header-wrapper" class="${properties.kcHeaderWrapperClass!}">
                <a href="${client.baseUrl}">
                    <img
                        src="${url.resourcesPath}/img/ErWIn_Portal_Wort_Bildmarke_RGB_Anwendung_HG_Blau.svg"
                        alt="Logo Schulportal"
                        class="header-logo"
                        width="354"
                        height="60"
                    />
                </a>
                <a class="header-help" target="_blank" href="https://medienberatung.iqsh.de/schulportal-sh.html">${msg("help")}</a>
            </div>
            <div class="light-header"></div>
        </div>
        <div class="title-logo">
            <img
                src="${url.resourcesPath}/img/ErWIn_Portal_Wort_Bildmarke_RGB_Anwendung_HG_Weiss.svg"
                alt="Logo Schulportal"
            />
        </div>
        <div class="${properties.kcFormCardClass!}">
            <header class="${properties.kcFormHeaderClass!}">
                <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
                    <div class="${properties.kcLocaleMainClass!}" id="kc-locale">
                        <div id="kc-locale-wrapper" class="${properties.kcLocaleWrapperClass!}">
                            <div id="kc-locale-dropdown" class="${properties.kcLocaleDropDownClass!}">
                                <a href="#" id="kc-current-locale-link">${locale.current}</a>
                                <ul class="${properties.kcLocaleListClass!}">
                                    <#list locale.supported as l>
                                        <li class="${properties.kcLocaleListItemClass!}">
                                            <a class="${properties.kcLocaleItemClass!}" href="${l.url}">${l.label}</a>
                                        </li>
                                    </#list>
                                </ul>
                            </div>
                        </div>
                    </div>
                </#if>
                <#if !(auth?has_content && auth.showUsername() && !auth.showResetCredentials())>
                    <#if displayRequiredFields>
                        <div class="${properties.kcContentWrapperClass!}">
                            <div class="${properties.kcLabelWrapperClass!} subtitle">
                                <span class="subtitle"><span class="required">*</span> ${msg("requiredFields")}</span>
                            </div>
                            <div class="col-md-10">
                                <h1 id="kc-page-title"><#nested "header"></h1>
                            </div>
                        </div>
                    <#else>
                        <h1 id="kc-page-title" data-testid="login-page-title"><#nested "header"></h1>
                        <div class="card-divider"></div>
                    </#if>
                <#else>
                    <#if displayRequiredFields>
                        <div class="${properties.kcContentWrapperClass!}">
                            <div class="${properties.kcLabelWrapperClass!} subtitle">
                                <span class="subtitle"><span class="required">*</span> ${msg("requiredFields")}</span>
                            </div>
                            <div class="col-md-10">
                                <#nested "show-username">
                                <div id="kc-username" class="${properties.kcFormGroupClass!}">
                                    <label id="kc-attempted-username">${auth.attemptedUsername}</label>                                    
                                </div>
                            </div>
                        </div>
                    <#else>
                        <#nested "show-username">
                        <div id="kc-username" class="${properties.kcFormGroupClass!}">
                            <label id="kc-attempted-username">${auth.attemptedUsername}</label>                            
                        </div>
                    </#if>
                </#if>
            </header>

            <#-- SPSH: custom messages for failed OTP authentication and update password form -->
            <#-- Remove all whitespaces and linebreaks from the message key to-->
            <#assign customMessages = {
                "Authenticationfailed.falscherOTP-Wert": msg("authenticationOtpFailedMessage"),
                "Authenticationfailed.falscheOTP-Pin": msg("authenticationOtpFailedMessage"),
                "Authenticationfailed.wrongotpvalue": msg("authenticationOtpFailedMessage"),
                "Authenticationfailed.wrongotppin": msg("authenticationOtpFailedMessage"),
                "Authenticationfailed.": msg("authenticationFailedMessage"),
                "Authenticationfailed.falscherOTP-WertfrühererOTP-Wertwiederverwendet": msg("authenticationOtpUsedAgainFailedMessage"),                
                "Authenticationfailed.wrongotpvalue.previousotpusedagain": msg("authenticationOtpUsedAgainFailedMessage"),
                "Authenticationfailed.1passendeToken,Failcounterexceeded": msg("authenticationFailedFailcounterExceededMessage"),
                "Authenticationfailed.matching1tokens,Failcounterexceeded": msg("authenticationFailedFailcounterExceededMessage"),
                "UngültigesPasswort:Esmussmindestens1Sonderzeichenbeinhalten." : msg("mindPasswordGuidelines"),
                "UngültigesPasswort:Esmussmindestens1Großbuchstabenbeinhalten." : msg("mindPasswordGuidelines"),
                "UngültigesPasswort:Esmussmindestens1Kleinbuchstabenbeinhalten." : msg("mindPasswordGuidelines"),
                "UngültigesPasswort:Esmussmindestens8Zeichenlangsein." : msg("mindPasswordGuidelines"),
                "UngültigesPasswort:Esmussmindestens1Zahl(en)beinhalten." : msg("mindPasswordGuidelines"),
                "UngültigesPasswort:Esdarfnichteinemderletzten3Passwörterentsprechen." : msg("mindPasswordGuidelines"),
                "UngültigesPasswort:EsentsprichtnichtdemRegex-Muster." : msg("mindPasswordGuidelines"),
                "ERR904:Theusercannotbefoundinanyresolverinthisrealm!" : msg("userNotFound"),
                "Authenticationfailed.Theuserhasnotokensassigned" : msg("userNotFound")
            }>
    
            <div id="kc-content">
                <div id="kc-content-wrapper">
                <#-- App-initiated actions should not see warning messages about the need to complete the action -->
                <#-- during login.                                                                               -->
                <#-- SPSH: commented the following block to customize warning messages                           -->
                <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??) && message.type != 'info'>
                    <div class="alert-${message.type} ${properties.kcAlertClass!} pf-m-<#if message.type == 'error'>danger<#else>${message.type}</#if>">
                        <div class="pf-c-alert__icon">
                            <#if message.type == 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
                            <#if message.type == 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
                            <#if message.type == 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
                            <#if message.type == 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>
                        </div>
                        <#if message?? && message.summary??>
                            <#assign key = message.summary?replace(" ", "")?replace("\n", "")?replace("\t", "")>
                            <#if customMessages[key]??>
                                <#assign customMessage = customMessages[key]>
                            </#if>
                        </#if>           
                        <#if customMessage??>
                            <!-- Verwende die angepasste Nachricht -->
                            <span class="${properties.kcAlertTitleClass!}">${customMessage}</span>
                        <#else>
                            <!-- Fallback auf die ursprüngliche Nachricht -->
                            <span class="${properties.kcAlertTitleClass!}">${kcSanitize(message.summary)?no_esc}</span>
                        </#if>
                    </div>
                </#if>

                <#nested "form">

                <#if auth?has_content && auth.showTryAnotherWayLink()>
                    <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post">
                        <div class="${properties.kcFormGroupClass!}">
                            <input type="hidden" name="tryAnotherWay" value="on"/>
                            <a href="#" id="try-another-way"
                                onclick="document.forms['kc-select-try-another-way-form'].submit();return false;">${msg("doTryAnotherWay")}</a>
                        </div>
                    </form>
                </#if>

                <#nested "socialProviders">

                <#if displayInfo>
                    <div id="kc-info" class="${properties.kcSignUpClass!}">
                        <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                            <#nested "info">
                        </div>
                    </div>
                </#if>
                </div>
            </div>
        </div>
    </div>
    <div id="schulportal-footer" class="light-footer">
        <div class="footer-items">
            <a
                class="footer-item"
                href="https://www.secure-lernnetz.de/helpdesk"
                rel="noopener noreferrer"
                target="_blank"
            >
                ${msg("contact")}
            </a>
            <a
                class="footer-item"
                href="https://medienberatung.iqsh.de/schulportal-sh.html"
                rel="noopener noreferrer"
                target="_blank"
            >
                ${msg("help")}
            </a>
            <a
                class="footer-item"
                href="${client.baseUrl}/impressum_datenschutzerklaerung.html"
                target="_blank"
                rel="noopener noreferrer"
            >
                ${msg("legalNotice")}
            </a>
            <a
                class="footer-item"
                href="${client.baseUrl}/impressum_datenschutzerklaerung.html#privacy_policy"
                target="_blank"
                rel="noopener noreferrer"
            >
                ${msg("privacyPolicy")}
            </a>
            <a
                class="footer-item"
                href="${client.baseUrl}/impressum_datenschutzerklaerung.html#accessibility"
                target="_blank"
                rel="noopener noreferrer"
            >
                ${msg("accessibility")}
            </a>
            <a
                class="footer-item"
                href="${properties.statusUrl!}"
                target="_blank"
                rel="noopener noreferrer"
            >
                ${msg("systemStatus")}
            </a>
        </div>
        <div class="footer-logos">
            <a
                href="https://www.dataport.de/services-produkte/it-produkte/projekt-erwin/"
                rel="noopener noreferrer"
                target="_blank"
            >
                <img
                    alt="Logo ErWIn Portal"
                    class="footer-logo"
                    src="${url.resourcesPath}/img/Logo-ErWIn-Portal-dunkel.svg"
                />
            </a>
            <div class="footer-logo-divider"></div>           
            <a
                href="https://www.bmfsfj.de/"
                rel="noopener noreferrer"
                target="_blank"
            >
                <img
                    alt="Logo BMBF"
                    class="footer-logo"
                    src="${url.resourcesPath}/img/digitalPakt.svg"
                />
            </a>
        </div>
    </div>
    <div class="dark-footer"></div>
</body>
</html>
</#macro>
