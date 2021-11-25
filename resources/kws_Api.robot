*** Settings ***
Library        RequestsLibrary
Library    Collections

*** Variables ***
${URL}         https://fakerestapi.azurewebsites.net/api/v1/
&{BOOK_15}    
...      id=15
...      title=Book 15
...      pageCount=1500

&{BOOK_2323}    id=2323
...    title=teste
...    description=teste
...    pageCount=200
...    excerpt=teste
...    publishDate=2021-11-17T16:24:19.875Z

&{BOOK_300}    id=300
...    title=Atualizei este livro
...    description=livro de teste
...    pageCount=1
...    excerpt=teste
...    publishDate=2021-11-17T16:24:19.875Z



*** Keywords ***

Conectar API
    Create Session      fakeAPI    ${URL}

Requisitar todos os livros
    ${RESPOSTA}    GET On Session    fakeAPI    Books
    Log            ${RESPOSTA.text}    
    Set Test Variable    ${RESPOSTA}

Requisitar o livro
    [Arguments]            ${ID_LIVRO}
    ${RESPOSTA}            GET On Session    fakeAPI    Books/${ID_LIVRO}
    Log                    ${RESPOSTA.text}    
    Set Test Variable      ${RESPOSTA}


Cadastrar um novo livro
    ${HEADERS}     Create Dictionary    content-type=application/json
    ${RESPOSTA}    POST On Session         fakeAPI    Books
    ...                                 data={"id": 2323,"title": "teste","description": "teste","pageCount": 200,"excerpt": "teste","publishDate": "2021-11-17T16:24:19.875Z"}
    ...                                 headers=${HEADERS}
    Log                                 ${RESPOSTA.text}
    Set Test Variable                   ${RESPOSTA}
    ${BOOK}       Set Variable     ${BOOK_2323}
    Set Test Variable    ${BOOK}
    ${ID}  Set Variable   ${BOOK.id}
    Set Test Variable    ${ID}

Alteração do livro (PUT)
    [Arguments]        ${ID}
    ${HEADERS}     Create Dictionary    content-type=application/json
    ${RESPOSTA}    PUT On Session    fakeAPI    Books/${ID} 
    ...            json=&{BOOK_300}
    #...            data={"id": 300,"title": "teAtualizei este livroste","description": "livro de teste","pageCount": 1,"excerpt": "teste","publishDate": "2021-11-17T16:24:19.875Z"}ok
    ...            headers=${HEADERS}
    Log                                  ${RESPOSTA.text}    
    Set Test Variable                    ${RESPOSTA} 
    ${BOOK}       Set Variable       ${BOOK_300}
    Set Test Variable    ${BOOK}




# CONFERENCIAS
Coferir reason 
    [Arguments]        ${REASON_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.reason}        ${REASON_DESEJADO}

Conferir o status code
    [Arguments]        ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.status_code}    ${STATUSCODE_DESEJADO}

Conferir se retornou uma lista com ${QTD_LIVROS} livros
    Length Should Be    ${RESPOSTA.json()}                  ${QTD_LIVROS}

Conferir se retorna todos os dados corretos do livro
    [Arguments]                       ${ID_LIVRO}
    
    Dictionary Should Contain Item    ${RESPOSTA.json()}   id               ${BOOK_15.id}  
    Dictionary Should Contain Item    ${RESPOSTA.json()}   title            ${BOOK_15.title}
    Dictionary Should Contain Item    ${RESPOSTA.json()}   pageCount        ${BOOK_15.pageCount}

    Should Not Be Empty               item                 ${RESPOSTA.json()["description"]}
    Should Not Be Empty               item                 ${RESPOSTA.json()["excerpt"]}
    Should Not Be Empty               item                 ${RESPOSTA.json()["publishDate"]}


Conferir se retorna todos os dados do livro 
    [Arguments]            ${ID}
    Log          ${RESPOSTA.json()["id"]}
    Dictionary Should Contain Item    ${RESPOSTA.json()}   id               ${BOOK.id}  
    Dictionary Should Contain Item    ${RESPOSTA.json()}   title            ${BOOK.title}
    Dictionary Should Contain Item    ${RESPOSTA.json()}   pageCount        ${BOOK.pageCount}

    Should Not Be Empty               item                 ${RESPOSTA.json()["description"]}
    Should Not Be Empty               item                 ${RESPOSTA.json()["excerpt"]}
    Should Not Be Empty               item                 ${RESPOSTA.json()["publishDate"]}

Deletar um livro
    [Arguments]        ${ID}
    ${RESPOSTA}    DELETE On Session    fakeAPI    Books/${ID}
    Log            ${RESPOSTA.text}    
    Set Test Variable    ${RESPOSTA} 


Conferir o delete do lista
    Should Be Empty    ${RESPOSTA.text}    