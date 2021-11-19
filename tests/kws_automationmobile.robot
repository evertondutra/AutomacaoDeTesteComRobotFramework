*** Settings ***
Library     AppiumLibrary
Test Setup            Abrir Aplicativo
Test Teardown         Fechar Aplicativo

*** Test Cases ***

Caso de teste 01: Pesquisar canal "Pingo nos is"
    [Tags]            INSCREVER
    Dado que o cliente esteja na tela Home
    E pesquise um video sobre "Pingo nos is"
    E acessar o canal da Pingo nos is
    Quando clicar em inscreves-se
    Então será apresentado com inscrito

*** Keywords ***


Abrir Aplicativo
    Set Appium Timeout         20
    Open Application           http://localhost:4723/wd/hub
    ...                        platformName=Android
    ...                        deviceName=9885e630474a354e4f
    ...                        automationName=uiautomator2
    ...                        appPackage=com.google.android.youtube
    ...                        appActivity=com.google.android.youtube.HomeActivity
    ...                        autoGrantPermissions=true

Fechar Aplicativo
    Capture Page Screenshot
    Close Application

Dado que o cliente esteja na tela Home
    Wait Until Element Is Visible        accessibility_id=Notificações
    Wait Until Element Is Visible        accessibility_id=YouTube

E pesquise um video sobre "${PESQUISA}"
    Click Element                        accessibility_id=Pesquisar
    Input Text         id=search_edit_text           ${PESQUISA}
    Press Keycode      66

E acessar o canal da Pingo nos is
    Wait Until Element Is Visible        id=com.google.android.youtube:id/player_fragment_container

    Click Element                        id=com.google.android.youtube:id/player_fragment_container
Quando clicar em inscreves-se
    Wait Until Element Is Visible        accessibility_id=Inscreva-se em Os Pingos nos Is.
    Click Element                        accessibility_id=Inscreva-se em Os Pingos nos Is.
    
Então será apresentado com inscrito
    Wait Until Element Is Visible    accessibility_id=Cancelar inscrição de Os Pingos nos Is.