*** Settings ***
Library            RequestsLibrary
Library            Collections
Resource           ../resources/kws_Api.robot

Test Setup         Conectar API

*** Test Cases ***
Buscar a listagem de todos os livros
    Requisitar todos os livros
    Conferir o status code  200
    Coferir reason     OK
    Requisitar todos os livros
    Conferir se retornou uma lista com 200 livros

Buscar um livro específico (GET e um livro específico)
    [Tags]                    ID
    Requisitar o livro        15
    Conferir o status code    200
    Coferir reason            OK
    Conferir se retorna todos os dados corretos do livro    15
    

Cadastrar um novo livro (POST)
    [Tags]                    POST
    Cadastrar um novo livro
    Coferir reason     OK
    Conferir o status code    200
    Conferir se retorna todos os dados corretos do novo livro

Alterar um livro (PUT) 150
    [Tags]        PUT
    Alteração do livro (PUT)    163
    Coferir reason     OK
    Conferir o status code    200
    Conferir se retorna todos os dados do livro 

Deletar um livro (DELETE)
    [Tags]        DELETE
    Deletar um livro    100
    Conferir se o delete do lista
    Coferir reason     OK
    Conferir o status code    200