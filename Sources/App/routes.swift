import Vapor

var messages = [Message]()

func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render("index")
    }
    
    app.post("send") { req async throws in
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
