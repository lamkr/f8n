abstract class ICrudStore<TEntity, TId>
{
  Future<TId> create( TEntity entity );

  Future<TEntity> read( TId id );
}