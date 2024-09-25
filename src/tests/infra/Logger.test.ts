import Logger from "../../infra/logger/Logger"


describe('Logger', () => {

    beforeEach(() => {
        process.env.LOG_LEVEL = 'DEBUG'
    })

    it('should be instance logger', () => {
        const logger = new Logger()
        expect(logger).not.toBeNull()
    })
})