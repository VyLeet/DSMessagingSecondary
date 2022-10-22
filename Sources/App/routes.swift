import Vapor

var messages = [Message]()

func routes(_ app: Application) throws {
    app.post("send") { req async throws -> Response in
        guard let message = try? req.content.decode(Message.self) else {
            return req.redirect(to: "/")
        }
        
        messages.append(message)
        
        return req.redirect(to: "list")
    }

    app.get("list") { req async throws in
        try await req.view.render("list", ["messages": messages])
    }
}
