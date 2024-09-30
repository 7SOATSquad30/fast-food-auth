export default interface CryptoService {

    decrypt(secret: string): Promise<string>
}