import XCTest
import Nimble
import GCDWebServers

class ExampleUITests: XCTestCase {

    var app: XCUIApplication!
    var mockServer: GCDWebServer!

    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        Nimble.AsyncDefaults.Timeout = 5

        mockServer = GCDWebServer()

        do {
            try mockServer.start(options: [
                GCDWebServerOption_BindToLocalhost: true,
                GCDWebServerOption_Port: 8088,
                GCDWebServerOption_AutomaticallySuspendInBackground: false
                ])
        } catch let e {
            fail("Could not start GCD Mock Server, reason: \(e)")
        }

        mockServer.addHandler(forMethod: "GET", path: "/foo", request: GCDWebServerRequest.self, processBlock: { request in
            let response = GCDWebServerDataResponse(text: "Some content")
            response?.statusCode = 200
            return response
        })

        app = XCUIApplication()
        app.launchEnvironment["API_URL"] = "http://localhost:8088"
        app.launch()
    }

    func testDisplayContentFromAPI() {
        expect(self.app.staticTexts["Some content"].exists).toEventually(beTrue())
    }
    
}
