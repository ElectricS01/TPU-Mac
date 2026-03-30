// @generated
// This file was automatically generated and should not be edited.

@_spi(Internal) @_spi(Unsafe) import ApolloAPI

public struct SearchModeInput: InputObject {
  @_spi(Unsafe) public private(set) var __data: InputDict

  @_spi(Unsafe) public init(_ data: InputDict) {
    __data = data
  }

  public init(
    mode: GraphQLEnum<GallerySearchMode>,
    value: GraphQLNullable<String> = nil
  ) {
    __data = InputDict([
      "mode": mode,
      "value": value
    ])
  }

  public var mode: GraphQLEnum<GallerySearchMode> {
    get { __data["mode"] }
    set { __data["mode"] = newValue }
  }

  public var value: GraphQLNullable<String> {
    get { __data["value"] }
    set { __data["value"] = newValue }
  }
}
