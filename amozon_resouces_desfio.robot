*** Settings ***
Library             SeleniumLibrary

*** Variables ***
${BROWSER}                                   chrome
${URL}                                       https://www.amazon.com.br/
${ID_PESQUISA}                               twotabsearchtextbox
${ID_PESQUISA_BOTTON}                        nav-search-submit-button
${ID_CARINHO_BOTTON}                         nav-cart
${ID_CARINHO_COMPRA_BOTTON}                  add-to-cart-button
${NAO_OBRIGADO}                              //input[contains(@aria-labelledby,'attachSiNoCoverage-announce')]
${ADICIONADO_NO_CARRINHO}                    //h1[@class='a-size-medium-plus a-color-base sw-atc-text a-text-bold'][contains(.,'Adicionado ao carrinho')]
${ID_CARRINO_TEXT}                           sc-active-items-header
${ID_EXCLUIR}                                //button[contains(@aria-label,'Excluir Console Xbox Series S')]

*** Keywords ***
Abrir o navegador
    Open Browser                             browser=${BROWSER}    
    ...                                      options=add_experimental_option("detach", True)
    Maximize Browser Window
    
Fechar o navegador
    Capture Page Screenshot
    Close Browser

Acessar a home page do site Amazon.com.br
    Go To    url=${URL}
    Sleep    10s
Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
    Input Text                               locator=${ID_PESQUISA}  
    ...                                      text=${PRODUTO}

Clicar no botão de pesquisa
    Click Element                            locator=${ID_PESQUISA_BOTTON}

Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
    Wait Until Element Is Visible            locator=//h2[contains(@aria-label,'${PRODUTO}')]
    Scroll Element Into View                 locator=//img[contains(@alt,'${PRODUTO}')]

Adicionar o produto "${PRODUTO}" no carrinho
    Click Element                            locator=//a[@class='a-link-normal s-line-clamp-4 s-link-style a-text-normal'][contains(.,'${PRODUTO}')]
    Wait Until Element Is Visible            locator=${ID_CARINHO_COMPRA_BOTTON}
    Sleep   5s
    Click Button                             locator=${ID_CARINHO_COMPRA_BOTTON}
    Wait Until Element Is Visible            locator=${NAO_OBRIGADO}
    Click Button                             locator=${NAO_OBRIGADO}

Verificar se o produto "${PRODUTO}" foi adicionado com sucesso
    Wait Until Element Is Visible            locator=${ADICIONADO_NO_CARRINHO}
    Click Link                               locator=${ID_CARINHO_BOTTON}
    Wait Until Element Is Visible            locator=//span[@class='a-truncate-cut'][contains(.,'${PRODUTO}')]
Remover o produto "${PRODUTO}" do carrinho
    Wait Until Element Is Visible            locator=${ID_CARRINO_TEXT}
    Element Should Be Visible                locator=//span[@class='a-truncate-cut'][contains(.,'${PRODUTO}')]
    Click Element                            locator=${ID_EXCLUIR}
Verificar se o carrinho fica vazio
    Wait Until Element Is Visible             locator=//span[@class='a-size-medium sc-number-of-items'][contains(.,'Subtotal (0 produtos):')]

