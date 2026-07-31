import ProjectDescription

let tuist = Tuist(
    fullHandle: "bogdanpetkanych/flick",
    project: .tuist(
        generationOptions: .options(
            enableCaching: true
        )
    )
)
