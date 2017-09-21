import Quick
import Nimble
import KenticoCloud

class GetItemsSpec: QuickSpec {
    override func spec() {
        describe("Get live items request") {
            
            let client = DeliveryClient.init(projectId: TestConstants.projectId)

            //MARK: Custom Model mapping
            context("using query parameter objects and custom model mapping", {
                
                it("returns array of items") {
                    
                    let contentTypeParameter = QueryParameter.init(parameterKey: QueryParameterKey.type, parameterValue: "cafe")
                    
                    waitUntil(timeout: 5) { done in
                        client.getItems(modelType: CafeTestModel.self, queryParameters: [contentTypeParameter], completionHandler: { (isSuccess, items, error) in
                            if !isSuccess {
                                fail("Response is not successful. Error: \(String(describing: error))")
                            }
                            
                            if let items = items {
                                let itemsCount = items.count
                                let expectedCount = 11
                                expect(itemsCount) == expectedCount
                                done()
                            }
                        })
                    }
                }
            })
            

            context("using custom query and custom model mapping", {
                
                it("returns array of items") {
                    
                    let customQuery = "items?system.type=cafe&order=elements.country[desc]&limit=3"
                    
                    waitUntil(timeout: 5) { done in
                        client.getItems(modelType: CafeTestModel.self, customQuery: customQuery, completionHandler: { (isSuccess, items, error) in
                            if !isSuccess {
                                fail("Response is not successful. Error: \(String(describing: error))")
                            }
                            
                            if let items = items {
                                let itemsCount = items.count
                                let expectedCount = 3
                                expect(itemsCount) == expectedCount
                                done()
                            }
                        })
                    }
                }
            })
            
            //MARK: Auto mapping using Delivery element types
            context("using query parameter objects and Delivery element types", {
                
                it("returns array of items") {
                    let contentTypeParameter = QueryParameter.init(parameterKey: QueryParameterKey.type, parameterValue: "cafe")
                    
                    let languageParameter = QueryParameter.init(parameterKey: QueryParameterKey.language, parameterValue: "es-ES")
                    
                    let parameters = [contentTypeParameter, languageParameter]
                    
                    waitUntil(timeout: 5) { done in
                        client.getItems(modelType: ArticleTestModel.self, queryParameters: parameters, completionHandler: { (isSuccess, items, error) in
                            if !isSuccess {
                                fail("Response is not successful. Error: \(String(describing: error))")
                            }
                            
                            if let items = items {
                                let itemsCount = items.count
                                let expectedCount = 11
                                expect(itemsCount) == expectedCount
                                done()
                            }
                        })
                    }
                }
            })
            
            context("using custom query and Delivery element types", {
                
                it("returns array of items") {
                    let customQuery = "items?system.type=article&order=elements.title[desc]&limit=4"
                    
                    waitUntil(timeout: 5) { done in
                        client.getItems(modelType: ArticleTestModel.self, customQuery: customQuery, completionHandler: { (isSuccess, items, error) in
                            if !isSuccess {
                                fail("Response is not successful. Error: \(String(describing: error))")
                            }
                            
                            if let items = items {
                                let itemsCount = items.count
                                let expectedCount = 4
                                expect(itemsCount) == expectedCount
                                done()
                            }
                        })
                    }
                }
            })
            
        }
    }
}
